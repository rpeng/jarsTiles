package {
  import flash.display.*;
  import flash.utils.*;
  import flash.events.*;

  public class Spinner extends Sprite {
    private var timer:Timer;
    private var rect:Sprite;
      
    public function Spinner () {
      // Create a rectangle graphic
      rect = new Sprite();
      rect.x = 200;
      rect.y = 200;
      rect.graphics.lineStyle(1);
      rect.graphics.beginFill(0x0000FF);
      rect.graphics.drawRect(0, 0, 150, 75);
      addChild(rect);

      // Register to be notified when Flash Player gains or loses 
      // system focus
      addEventListener(Event.ACTIVATE, activateListener);
      addEventListener(Event.DEACTIVATE, deactivateListener);

      // Create a timer to use for animation
      timer = new Timer(50, 0);
      timer.addEventListener(TimerEvent.TIMER, timerListener);
    }

    // Rotates the rectangle graphic
    private function timerListener (e:TimerEvent):void {
      rect.rotation += 10;
    }

    // Handles Event.ACTIVATE events
    private function activateListener (e:Event):void {
      // Start rotating the rectangle graphic
      timer.start();
    }

    // Handles Event.DEACTIVATE events
    private function deactivateListener (e:Event):void {
      // Stop rotating the rectangle graphic
      timer.stop();
    }
  }
}
