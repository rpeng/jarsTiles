package {
  import flash.display.*;
  import flash.events.*; 
  import flash.net.*;   

  // Demonstrates the code required to load external XML
  public class LoadXML extends Sprite {
    // The property that will eventually contain the loaded XML
    private var novel:XML;
    // The object used to load the XML
    private var urlLoader:URLLoader;
    
    // Constructor
    public function LoadXML () {
      // Specify the location of the external XML
      var urlRequest:URLRequest = new URLRequest("novel.xml");
      // Create an object that can load external text data
      urlLoader = new URLLoader();
      // Register to be notified when the XML finishes loading
      urlLoader.addEventListener(Event.COMPLETE, completeListener);
      // Load the XML
      urlLoader.load(urlRequest);
    }

    // Method invoked automatically when the XML finishes loading
    private function completeListener(e:Event):void {
      // The string containing the loaded XML is stored in the URLLoader
      // object's data property (urlLoader.data). To create a new XML 
      // instance from that loaded string, we pass it to the XML constructor
      novel = new XML(urlLoader.data);
      trace(novel.toXMLString());  // Display the loaded XML, now converted 
                                   // to an XML object
    }
  }
}
