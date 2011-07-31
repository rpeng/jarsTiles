package {
  import flash.display.*;
  import flash.events.*;
  import flash.text.*;
  import flash.net.*;

  // Sets the color of a TextField to match the color of a selected 
  // pixel in an image.
  public class ColorPicker extends Sprite {
    private var img:Bitmap;           // The Bitmap object
    private var imgContainer:Sprite;  // Container for the Bitmap object
    private var t:TextField;          // The TextField that will be colored

    // Constructor function
    public function ColorPicker() {
      // Create the TextField and add it to 
      // the ColorPicker's display hierarchy
      t =  new TextField();
      t.text = "Essential ActionScript 3.0";
      t.autoSize = TextFieldAutoSize.LEFT;
      addChild(t);

      // Load the image
      var loader:Loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.INIT, 
                                                initListener);
      loader.load(new URLRequest("sunset.jpg"));
    }

    // Invoked when the image has initialized
    private function initListener (e:Event):void {
      // Obtain a reference to the loaded Bitmap object
      img = e.target.content;
      // Put the loaded bitmap in a Sprite so we can detect mouse 
      // interaction with it
      imgContainer = new Sprite();
      imgContainer.addChild(img);
      // Add the Sprite to the ColorPicker's display hierarchy
      addChild(imgContainer);
      imgContainer.y = 30;
      // Start listening for mouse movement
      imgContainer.addEventListener(MouseEvent.MOUSE_MOVE, 
                                    mouseMoveListener);
    }

    // Invoked when the mouse moves over the Sprite containing the image
    private function mouseMoveListener (e:MouseEvent):void {
      // Set the text color to the pixel currently under the mouse
      t.textColor = img.bitmapData.getPixel32(e.localX, e.localY);
    }
  }
}
