package {
  import flash.display.*;
  import flash.events.*;
  import mx.core.MovieClipAsset;
  import mx.core.MovieClipLoaderAsset;
  import mx.core.SpriteAsset;
  import mx.core.BitmapAsset;
  import mx.core.ByteArrayAsset;

  public class VariableLevelEmbedDemo extends Sprite {
    [Embed(source="embeds/photo.jpg")]
    private var Photo:Class;

    [Embed(source="embeds/line.svg")]
    private var SVGLine:Class; 

    [Embed(source="embeds/fp9app.swf")]
    private var FP9App:Class;

    [Embed(source="embeds/fp8app.swf", symbol="Ball")]
    private var FP8Ball:Class;

    [Embed(source="embeds/fp9app.swf", mimeType="application/octet-stream")]
    private var FP9BinaryData:Class;

    public function VariableLevelEmbedDemo () {
      // Variable-level bitmap
      var photo:BitmapAsset = new Photo();
      addChild(photo);

      // Variable-level SVG
      var line:SpriteAsset = new SVGLine();
      addChild(line);

      // Variable-level FP8 SWF Symbol
      var fp8ball:MovieClipAsset = new FP8Ball();
      addChild(fp8ball);

      // Variable-level FP9 SWF
      var fp9app:MovieClipLoaderAsset = new FP9App();
      addChild(fp9app);
      
      // To access a symbol's class or regular class in the embedded .swf,
      // wait for the embedded .swf file to initialize
      Loader(fp9app.getChildAt(0)).contentLoaderInfo.addEventListener(
                                                        Event.INIT, 
                                                        fp9appInitListener);

      // Variable-level binary data (FP9 SWF)
      var fp9binarydata:ByteArrayAsset = new FP9BinaryData();
      var loader:Loader = new Loader();
      loader.loadBytes(fp9binarydata);
      addChild(loader);

      // To access a symbol's class or regular class in the embedded .swf,
      // wait for the embedded .swf file to initialize
      loader.contentLoaderInfo.addEventListener(Event.INIT, 
                                                fp9binarydataInitListener);      
    }
    
    private function fp9appInitListener (e:Event):void {
      // Obtain a reference to the Ball symbol from the embedded .swf file
      var BallSymbol:Class = 
        e.target.content.loaderInfo.applicationDomain.getDefinition("Ball");
      // Make a new instance of the Ball symbol
      var ball:MovieClip = MovieClip(new BallSymbol());
      // Position the Ball instance and place it on screen
      ball.x = 220;
      ball.y = 240;
      addChild(ball);
    }

    private function fp9binarydataInitListener (e:Event):void {
      // Obtain a reference to the Ball symbol from the embedded .swf file
      var BallSymbol:Class = 
        e.target.content.loaderInfo.applicationDomain.getDefinition("Ball");
      // Make a new instance of the Ball symbol
      var ball:MovieClip = MovieClip(new BallSymbol());
      // Position the Ball instance and place it on screen
      ball.y = 200;
      addChild(ball);
    }
  }
}
