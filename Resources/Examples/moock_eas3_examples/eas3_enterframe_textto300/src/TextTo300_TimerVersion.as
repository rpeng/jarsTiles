package {
  import flash.display.*;
  import flash.events.*;  
  import flash.utils.*;
  import flash.text.*;  
  
  public class TextTo300_TimerVersion extends TextField {
    private var timer:Timer;
    
    public function TextTo300_TimerVersion () {
      timer = new Timer(50, 0);
      timer.addEventListener(TimerEvent.TIMER, moveTextRight);
    }

    public function moveTextRight (e:Event):void {
      if (x <= 300) {
        x += 10;
        if (x > 300) {
          x = 300;
        }
      } else {
        stop();
      }
    }

    public function start ():void {
      // Start playing the animation
      timer.start();
    }

    public function stop ():void {
      // Pause the animation
      timer.stop();
    }
  }
}
