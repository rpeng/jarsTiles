package {
  import flash.display.*;
  import flash.events.*;
  import flash.net.*;
  import flash.geom.*;
  import flash.filters.*;
  
  public class GrayscaleDemo extends Sprite {
    private var loader:Loader;

    public function GrayscaleDemo () {
      loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.INIT, 
                                                initListener);
      loader.load(new URLRequest("photo.jpg"));
    }

    private function initListener (e:Event):void {
      var loadedBitmapData:BitmapData = Bitmap(loader.content).bitmapData;
      toGrayscale(loadedBitmapData, 
                  loadedBitmapData,
                  loadedBitmapData.rect,
                  new Point(0,0));
      addChild(loader.content);
    }

    public function toGrayscale (source:BitmapData,
                                 dest:BitmapData,
                                 rect:Rectangle,
                                 point:Point):void {
      // Scale factors used to convert RGB to luminance, using weights 
      // based on Charles Poynton's color space FAQ, which cites
      // ITU-R Recommendation BT.709 as its source.
      // See: http://www.faqs.org/faqs/graphics/colorspace-faq/
      var redLuminance:Number = 0.212671;
      var greenLuminance:Number = 0.715160;
      var blueLuminance:Number = 0.072169;

      // Convert to grayscale by determining the average luminosity
      // of each pixel.
      var grayscaleFilter:ColorMatrixFilter = new ColorMatrixFilter(
                  new Array(redLuminance, greenLuminance, blueLuminance,0,0,
                            redLuminance, greenLuminance, blueLuminance,0,0,
                            redLuminance, greenLuminance, blueLuminance,0,0,
                                       0,              0,             0,1,0));

      dest.applyFilter(source, rect, point, grayscaleFilter);
    }
  }
}