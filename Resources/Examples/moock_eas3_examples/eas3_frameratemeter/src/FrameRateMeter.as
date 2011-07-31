package {
  import flash.display.*;
  import flash.events.*;
  import flash.utils.*;  
  import flash.text.*;  
  
  public class FrameRateMeter extends Sprite {
    private var lastFrameTime:Number;
    private var output:TextField;
    
    public function FrameRateMeter() {
      stage.frameRate = 60;
      
      output = new TextField();
      output.autoSize = TextFieldAutoSize.LEFT;
      output.border     = true;
      output.background = true;
      output.selectable = false;
      addChild(output);

      addEventListener(Event.ENTER_FRAME, enterFrameListener);
    }
    
    public function enterFrameListener (e:Event):void {
      var now:Number = getTimer();
      var elapsed:Number = now - lastFrameTime;
      var framesPerSecond:Number = Math.round(1000/elapsed);
      output.text = "Time since last frame: " + elapsed
             + "\nExtrapolated actual frame rate: " + framesPerSecond
             + "\nDesignated frame rate: " + stage.frameRate;
      lastFrameTime = now;
    }
  }
}
