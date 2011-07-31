package {
  import flash.display.*;
  import flash.text.*;
  
  public class TextAnimation extends Sprite {
    private var t:TextTo300_TimerVersion;
    
    public function TextAnimation () {
      // Create a TextTo300 instance
      t = new TextTo300_TimerVersion();
      t.text          = "Hello";
      t.autoSize      = TextFieldAutoSize.LEFT;
      addChild(t);

      // Start the animation
      t.start();
    }
  }
}
