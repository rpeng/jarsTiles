package {
  import flash.display.*;
  import flash.utils.*;
  import flash.events.*;
  import flash.geom.*;
  import flash.text.*;

  public class DissolveText extends Sprite {
    // Variables used for the dissolve effect
    private var randomSeed:int = Math.floor(Math.random() * int.MAX_VALUE);
    private var destPoint:Point = new Point(0, 0);
    private var numberOfPixels:int = 10;
    private var destColor:uint = 0xFF000000;
    
    // The BitmapData object into which the text will be drawn
    private var bitmapData:BitmapData;
    // A timer used to repeatedly invoke pixelDissolve()
    private var t:Timer;

    // Constructor
    public function DissolveText () {
      // Create the text
      var txt:TextField = new TextField();
      txt.text = "Essential ActionScript 3.0";
      txt.autoSize = TextFieldAutoSize.LEFT;
      txt.textColor = 0xFFFFFF;
      
      // Make the BitmapData object, sized to accommodate the text
      bitmapData = new BitmapData(txt.width, txt.height, false, destColor);
      // Draw the text into the BitmapData object
      bitmapData.draw(txt);
      
      // Associate the BitmapData object with a Bitmap object so it can
      // be displayed on screen
      var bitmap:Bitmap = new Bitmap(bitmapData);
      addChild(bitmap);

      // Start repeatedly invoking pixelDissolve()
      t = new Timer(10);
      t.addEventListener(TimerEvent.TIMER, timerListener);
      t.start();
    }

    // Handles TimerEvent.TIMER events
    private function timerListener (e:TimerEvent):void {
      dissolve();
    }

    // Performs the dissolve
    private function dissolve():void {
      // Call pixelDissolve() to dissolve the specified number of pixels,
      // and remember the returned random seed for next time. Using the 
      // returned random seed ensures a smooth dissolve.
      randomSeed = bitmapData.pixelDissolve(bitmapData, 
                                            bitmapData.rect,
                                            destPoint, 
                                            randomSeed, 
                                            numberOfPixels, 
                                            destColor);
      // Stop the dissolve when all pixels are the target color (i.e.,
      // when the width and height of the region in which the target color
      // does not exist are both 0)
      var coloredRegion:Rectangle = 
                bitmapData.getColorBoundsRect(0xFFFFFFFF, destColor, false);
      if (coloredRegion.width == 0 && coloredRegion.height == 0 ) {
        t.stop();
      }
    }
  }
}
