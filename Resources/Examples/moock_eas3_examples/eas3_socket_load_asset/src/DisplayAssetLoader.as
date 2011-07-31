package { 
  import flash.display.*;
  import flash.events.*;
  import flash.net.*;
  import flash.text.*;
  import flash.utils.*;
  import flash.system.*;

  public class DisplayAssetLoader extends Sprite  {
    // A constant representing the ASCII character for "end of transmission"
    public static const EOT:int = 4;
    // An on-screen TextField in which to display status messages
    private var statusField:TextField;
    // The socket object over which communication will occur
    private var socket:Socket;
    // A byte buffer in which to store the asset's binary data as it loads
    private var buffer:ByteArray = new ByteArray();
    // The Loader object used to generate the asset from 
    // the loaded binary data
    private var loader:Loader;

    // Class constructor
    public function DisplayAssetLoader () {
trace("sandbox type:" + Security.sandboxType);

      // Create the status TextField
      statusField = new TextField();
      statusField.border     = true;
      statusField.background = true;
      statusField.width = statusField.height = 350;
      addChild(statusField);

      // Create the socket object
      socket = new Socket();
      
      // Register for socket events
      socket.addEventListener(Event.CONNECT, connectListener);
      socket.addEventListener(Event.CLOSE, closeListener);
      socket.addEventListener(ProgressEvent.SOCKET_DATA, 
                              socketDataListener);
      socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorListener);

      // Tell the user we're about to try connecting to the socket      
      out("Attempting connection...");  
          
      // Attempt to connect to the socket
      try {
        socket.connect("localhost", 3000);
      } catch (e:Error) {
        out("Connection problem!\n");
        out(e.message);
      }
    }

    // Handles socket connection events
    private function connectListener (e:Event):void {
      out("Connected! Waiting for data...");
    }

    // Handles newly received data
    private function socketDataListener (e:ProgressEvent):void {
      out("New socket data arrived.");
      // When new bytes arrive, store them in a buffer for later processing
      socket.readBytes(buffer, buffer.length, socket.bytesAvailable);
    }

    // Handles socket disconnection events. When a disconnection occurs,
    // attempt to generate a display asset from the loaded bytes
    private function closeListener (e:Event):void {
      // First, check if we received the whole asset...
      // Retrieve the last byte in the buffer
      buffer.position = buffer.length - 1;
      var lastByte:int = buffer.readUnsignedByte();
      // If an "end of transmission" byte was never received, the 
      // asset's binary data didn't fully arrive, so don't 
      // generate the asset 
      if (lastByte != DisplayAssetLoader.EOT) {
        return;
      }
      
      // All clear, we can safely generate an asset from the bytes that 
      // were loaded. The last byte in the buffer is not part of the asset,
      // so truncate it.
      buffer.length = buffer.length - 1;
      
      // Now, create the Loader object that will generate  
      // the asset from the loaded bytes
      loader = new Loader();
      
      // Generate an asset from the loaded bytes
      loader.loadBytes(buffer);
  
      // Wait for the asset to initialize
      loader.contentLoaderInfo.addEventListener(Event.INIT, 
                                                assetInitListener);
    }

    // Puts the asset on screen when it's done initializing
    private function assetInitListener (e:Event):void {
      addChild(loader.content);
      out("Asset initialzed.");
    }

    // Handles I/O errors
    private function ioErrorListener (e:IOErrorEvent):void {
      out("I/O Error: " + e.text);
    }

    // Print status messages to the screen and the debugging console
    private function out (msg:*):void {
      trace(msg);
      statusField.appendText(msg + "\n");
    }
  }
}
