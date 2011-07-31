package {
  import flash.display.*;
  import flash.net.URLRequest;
  import flash.events.*
  import flash.text.*;

  public class SunsetViewer extends Sprite {
    private var loader:Loader;             // The asset loader
    private var progressOutput:TextField;  // The text field in which 
                                           // to display load progress
    // Constructor
    public function SunsetViewer () {
      // Create the Loader
      createLoader();
                                                      
      // Create the progress indicator
      createProgressIndicator();

      // Start the load operation
      load(new URLRequest("sunset.jpg"));
    }

    private function createLoader ():void {
      // Create the Loader
      loader = new Loader();

      // Register for events
      loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, 
                                                progressListener);
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE, 
                                                completeListener);
      loader.contentLoaderInfo.addEventListener(Event.INIT, 
                                                initListener);
      loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, 
                                                ioErrorListener);
      loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, 
                                                httpStatusListener);
    }

    private function createProgressIndicator ():void {
      progressOutput  = new TextField();
      progressOutput.autoSize   = TextFieldAutoSize.LEFT;
      progressOutput.border     = true;
      progressOutput.background = true;
      progressOutput.selectable = false;
      progressOutput.text       = "LOADING...";
    }
    
    private function load (urlRequest:URLRequest):void {
      loader.load(urlRequest);
      if (!contains(progressOutput)) {
        addChild(progressOutput);
      }
    }
    
    // Listener invoked whenever data arrives
    private function progressListener (e:ProgressEvent):void {
      // Update progress indicator. 
      progressOutput.text = "LOADING: " 
                          + Math.floor(e.bytesLoaded / 1024)
                          + "/" + Math.floor(e.bytesTotal / 1024) + " KB";
    }

    private function initListener (e:Event):void {
      addChild(loader.content);  // Add loaded asset to display list
    }

    // Listener invoked when the asset has been fully loaded
    private function completeListener (e:Event):void {
      // Remove progress indicator.
      removeChild(progressOutput);
    }

    // Listener invoked when a load error occurs
    private function ioErrorListener (e:IOErrorEvent):void {
      progressOutput.text = "LOAD ERROR";
    }

    private function httpStatusListener (e:HTTPStatusEvent):void {
      trace("http status: " + e.status);
    }
  }
}



