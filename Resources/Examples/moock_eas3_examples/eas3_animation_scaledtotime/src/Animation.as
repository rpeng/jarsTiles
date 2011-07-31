package {
  import flash.display.*;
  import flash.events.*;
  import flash.utils.*;  

  public class Animation extends Sprite {
    private var distancePerSecond:int = 50;  // Pixels to move per second
    private var now:int;                     // The current time
    private var then:int;                    // The last screen-update time
    private var circle:Shape;                // The object to animate
    
    public function Animation () {
      // Create the object to animate
      circle = new Shape();
      circle.graphics.beginFill(0x0000FF, 1);
      circle.graphics.lineStyle(1);
      circle.graphics.drawEllipse(0, 0, 25, 25);
      addChild(circle);

      // Initialize timestamps
      then = getTimer();
      now  = then;
      
      // Register for notification of scheduled screen-update checks
      addEventListener(Event.ENTER_FRAME, enterFrameListener);
    }

    //  Handles Event.ENTER_FRAME events
    private function enterFrameListener (e:Event):void {
      // Calculate how much time has passed since the last move
      then = now;
      now = getTimer();
      var elapsed:int = now - then;
      var numSeconds:Number = elapsed / 1000;
      
      // Calculate the amount move based on the amount of time that
      // has passed since the last move
      var moveAmount:Number = distancePerSecond * numSeconds;
      
      // Move the object
      circle.x += moveAmount;
    }
  }
}
