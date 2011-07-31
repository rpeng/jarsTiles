package {
  import flash.display.MovieClip;
  import flash.utils.Timer;
  import flash.events.TimerEvent;

  public class Star extends MovieClip {
    private var timer:Timer;

    public function Star () {
      timer = new Timer(100, 0);
      timer.addEventListener(TimerEvent.TIMER, timerListener);
      timer.start();
    }

    private function timerListener (e:TimerEvent):void {
      randomFade();
    }

    private function randomFade ():void {
      alpha = Math.random();
    }

    public function dispose ():void {
      timer.stop();
    }
  }
}