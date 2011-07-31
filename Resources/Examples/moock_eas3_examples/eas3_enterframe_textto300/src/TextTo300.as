package {
  import flash.display.*;
  import flash.events.*;  
  import flash.text.*;  
  
  public class TextTo300 extends TextField {
    public function TextTo300 () {
    }

    public function moveTextRight (e:Event):void {
      if (x <= 300) {
        x += 10;
        if (t.x > 300) {
          t.x = 300;
        }
      } else {
        stop();
      }
    }

    public function start ():void {
      // Start playing the animation
      addEventListener(Event.ENTER_FRAME, moveTextRight);
    }

    public function stop ():void {
      // Pause the animation
      removeEventListener(Event.ENTER_FRAME, moveTextRight);
    }
  }
}
