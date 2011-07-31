package {
  import flash.display.*;
  import flash.events.*;
  import flash.net.*;
  import flash.geom.*;
  import flash.filters.*;
  
  public class PaletteMapDemo extends Sprite {
    private var loader:Loader;

    public function PaletteMapDemo () {
      // Load a bitmap image
      loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.INIT, 
                                                initListener);
      loader.load(new URLRequest("sunset.jpg"));
    }

    // Invoked when the loaded image has initialized
    private function initListener (e:Event):void {
      addChild(loader.content);
      negative(Bitmap(loader.content).bitmapData);
      posterize(Bitmap(loader.content).bitmapData, 4);
    }

    public function negative (bitmapData:BitmapData):void {

      // Create the lookup tables
      var redLookupTable:Array  = new Array();
      var greenLookupTable:Array  = new Array();
      var blueLookupTable:Array  = new Array();
      for (var i:int = 0; i < 256; i++) {
        redLookupTable[i]   = (255-i) << 16;
        greenLookupTable[i] = (255-i) << 8;
        blueLookupTable[i]   = 255-i;
      }
      
      // Perform the lookup
      bitmapData.paletteMap(bitmapData, bitmapData.rect, new Point(),
                         redLookupTable, greenLookupTable, blueLookupTable);
                        
/*
      // Faster version, using a matrix filter
      var invertFilter:ColorMatrixFilter = new ColorMatrixFilter(
                                          new Array(-1, 0, 0,0,255,
                                                     0,-1, 0,0,255,
                                                     0, 0,-1,0,255,
                                                     0, 0, 0,1,0));
      bitmapData.applyFilter(bitmapData, bitmapData.rect, 
                             new Point(0,0), invertFilter);
*/ 
                            
    }    

    // Uses a lookup table to posterize an image
    public function posterize (bitmapData:BitmapData,
                               numColorsPerChannel:int):void {
      // Valid range is 1-256
      if (numColorsPerChannel < 1 || numColorsPerChannel > 256) {
        throw new Error("Number of colors per channel must be in the " + 
                        "range 1-255.");
      }

      // Create the lookup tables
      var redLookupTable:Array  = new Array();
      var greenLookupTable:Array  = new Array();
      var blueLookupTable:Array  = new Array();
      for (var i:int = 0; i < 256; i++) {
        redLookupTable[i] = 
                     (i-(i % Math.round(256/numColorsPerChannel))) << 16;
        greenLookupTable[i] = 
                     (i-(i % Math.round(256/numColorsPerChannel))) << 8;
        blueLookupTable[i] = 
                     (i-(i % Math.round(256/numColorsPerChannel)));
      }

      // Perform the lookup
      bitmapData.paletteMap(bitmapData, bitmapData.rect, new Point(),
                         redLookupTable, greenLookupTable, blueLookupTable); 
    }

  }
}