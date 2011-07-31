package {
  import flash.display.*;
  import flash.events.*;
  import flash.geom.*;
  import flash.net.*;
  import flash.filters.*;

  public class ScrapbookImage extends Sprite {
    private var numLoaded:int = 0;
    private var photoLoader:Loader;   // The photo loader
    private var borderLoader:Loader;  // The borter loader

    public function ScrapbookImage () {
      // Load the photograph
      photoLoader = new Loader();
      photoLoader.contentLoaderInfo.addEventListener(Event.INIT,
                                                     initListener);
      photoLoader.load(new URLRequest("photo.jpg"));

      // Load the border
      borderLoader = new Loader();
      borderLoader.contentLoaderInfo.addEventListener(Event.INIT,
                                                      initListener);
      borderLoader.load(new URLRequest("border.png"));
    }


    // Handles Event.INIT events for the loaded images
    private function initListener (e:Event):void {
      numLoaded++;
      // When those images have loaded, apply the effect
      if (numLoaded == 2) { 
        makeScrapbookImage();
      }
    }

    // Combines the border image with the photo image to produce
    // the aged photograph effect
    private function makeScrapbookImage ():void {
      // Retrieve the BitmapData object for the photograph
      var photoData:BitmapData = Bitmap(photoLoader.content).bitmapData;
      // Retrieve the BitmapData object for the border
      var borderData:BitmapData = Bitmap(borderLoader.content).bitmapData;
      // Create a BitmapData object that will hold the final 
      // photograph image
      var tempBitmapData:BitmapData = new BitmapData(borderData.width,
                                                     borderData.height,
                                                     true, 
                                                     0x00000000);

      // Copy the pixels  from the photograph, while applying the
      // border's Alpha channel
      tempBitmapData.copyPixels(photoData, 
                                borderData.rect,
                                new Point(0,0),
                                borderData,
                                new Point(0,0),
                                false);

      // A ColorMatrixFilter that will increase brightness
      var brightnessOffset:int = 70;
      var brightnessFilter:ColorMatrixFilter = new ColorMatrixFilter(
          new Array(1,0,0,0,brightnessOffset,
                    0,1,0,0,brightnessOffset,
                    0,0,1,0,brightnessOffset,
                    0,0,0,1,0));
     
      // A blur filter to make the image look fuzzy
      var blurFilter:BlurFilter = new BlurFilter(1, 1);
      
      // A drop shadow filter to make the image look like it's on paper
      var dropShadowFilter:DropShadowFilter = new DropShadowFilter(4, 35, 
                        0x2E2305, .6, 5, 12, 4, BitmapFilterQuality.MEDIUM);
                        
      // Calculate the area required to display the image 
      // and its drop shadow
      var filteredImageRect:Rectangle = tempBitmapData.generateFilterRect(
                                     tempBitmapData.rect, dropShadowFilter);

      // Create a BitmapData object that will hold the final image
      var scrapbookImage:BitmapData = 
                                     new BitmapData(filteredImageRect.width,
                                         filteredImageRect.height,
                                         true, 
                                         0xFFFFFFFF);
                                         
      // Apply the ColorMatrixFilter, which increases the brightness
      tempBitmapData.applyFilter(tempBitmapData,
                                 tempBitmapData.rect,
                                 new Point(0,0),
                                 brightnessFilter);

      // Apply the BlurFilter
      tempBitmapData.applyFilter(tempBitmapData,
                                 tempBitmapData.rect,
                                 new Point(0,0),
                                 blurFilter);

      // Apply the DropShadowFilter
      scrapbookImage.applyFilter(tempBitmapData,
                                 tempBitmapData.rect,
                                 new Point(-filteredImageRect.x,
                                           -filteredImageRect.y),
                                 dropShadowFilter);
      
      // Associate the scrapbookImage BitmapData object with a Bitmap
      // object for on-screen display
      var b:Bitmap = new Bitmap(scrapbookImage);
      addChild(b);
      b.x = 100;
      b.y = 75;
    }
  }
}
