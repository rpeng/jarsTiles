package {
  import flash.display.*;
  import flash.events.*;

  public class ClassLevelEmbedDemo extends Sprite {
    public function ClassLevelEmbedDemo () {
      // Class-level bitmap
      var photo:Photo = new Photo();
      addChild(photo);

      // Class-level SVG
      var svgline:SVGLine = new SVGLine();
      addChild(svgline);

      // Class-level FP8 .swf symbol
      var fp8ball:FP8Ball = new FP8Ball();
      addChild(fp8ball);

      // Class-level binary data (FP9 .swf)
      var fp9binarydata:FP9BinaryData = new FP9BinaryData();
      var loader:Loader = new Loader();
      loader.loadBytes(fp9binarydata);
      addChild(loader);
      // Wait for the embedded .swf file to initialize
      loader.contentLoaderInfo.addEventListener(Event.INIT, initListener);      
    }
    
    private function initListener (e:Event):void {
      // Obtain a reference to the Ball symbol from the embedded .swf file
      var BallSymbol:Class = Object(e.target.content).loaderInfo.applicationDomain.getDefinition("Ball");
      // Make a new instance of the Ball symbol
      var ball:MovieClip = MovieClip(new BallSymbol());
      // Position the Ball instance and place it on screen
      ball.x = 200;
      ball.y = 230;
      addChild(ball);
    }
  }
}
