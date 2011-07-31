package {
  import flash.display.*;
  import flash.events.*;
  import flash.utils.*;
  
  // A very simple animation class that demonstrates how to separate
  // animation duties from an object being animated
  public class Animator extends EventDispatcher {
    // Stores a reference to the object being animated
    private var target:DisplayObject;
    // Each time an animation starts we record its start time in startTime
    private var startTime:Number;
    // The duration of an animation, in milliseconds
    private var duration:Number;
    // Each time an animation starts we record the target's start 
    // position in startX and startY
    private var startX:Number;    
    private var startY:Number;
    // Each time an animation starts we record the difference between the 
    // starting position and the end position in deltaX and deltaY
    private var deltaX:Number;
    private var deltaY:Number;

    // The constructor function accepts a reference to the object that 
    // will be animated
    public function Animator (target:DisplayObject) {
      this.target = target;
    }    

    // Starts an animation that moves the target object from its current 
    // position to the specified new position (toX, toY), over 
    // 'duration' milliseconds
    public function animateTo (toX:Number, toY:Number, 
                               duration:Number):void {
      // Remember where the target was when this animation started
      startX = target.x;
      startY = target.y;

      // Calculate the difference between the target's starting position
      // and final destination
      deltaX = toX - target.x;
      deltaY = toY - target.y;
      startTime = getTimer();
      
      // Remember how long this animation should take
      this.duration  = duration;
      
      // Begin listening for Event.ENTER_FRAME events. Each time a
      // scheduled screen-update occurs, we'll update the position of 
      // the target object
      target.addEventListener(Event.ENTER_FRAME, enterFrameListener);
    }

    // Handles Event.ENTER_FRAME events. 
    private function enterFrameListener (e:Event):void {
      // Calculate the time elapsed since the animation started
      var elapsed:Number = getTimer()-startTime;
      // Calculate how much time has passed in the animation, as a
      // percentage of its total duration
      var percentDone:Number = elapsed/duration;
      // If the animation is not yet complete...
      if (percentDone < 1) {
        // ...update the position of the target object
        updatePosition(percentDone);
      } else {
        // ...otherwise place the target object at its final destination,
        // and stop listening for Event.ENTER_FRAME events
        updatePosition(1);
        target.removeEventListener(Event.ENTER_FRAME, enterFrameListener);
      }
    }

    // Sets the position of the target object to a percentage of the
    // distance between the animation start point and end point
    private function updatePosition (percentDone:Number):void {
      target.x = startX + deltaX*percentDone;
      target.y = startY + deltaY*percentDone;
    }
  }
}