package {
  import flash.display.*;
  import flash.events.*;
  import flash.net.*;
  
  // A simple example showing how to load an image.
  public class BitmapLoader extends Sprite {
    private var loader:Loader;  // The bitmap loader

    public function BitmapLoader() {
      // Create the loader
      loader = new Loader();
      
      // Wait for the bitmap to load and initialize
      loader.contentLoaderInfo.addEventListener(Event.INIT, 
                                                initListener);
                                                
      // Load the bitmap
      loader.load(new URLRequest("photo.jpg"));
    }

    private function initListener (e:Event):void {
      // Add loaded asset to display list
      addChild(loader.content); 

      // Retrieve the color value for 
      // the top-left pixel in the loaded bitmap
      trace(Bitmap(loader.content).bitmapData.getPixel(0, 0));
    }
  }
}
