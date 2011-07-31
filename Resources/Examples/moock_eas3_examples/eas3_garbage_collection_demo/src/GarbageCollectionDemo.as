package {
  import flash.display.*;  
  import flash.text.*;
  import flash.utils.*;
  import flash.events.*;  
  import flash.system.*;  
  
  public class GarbageCollectionDemo extends Sprite {
    public function GarbageCollectionDemo () {
      // This Sprite object is garbage collected after enough memory
      // is consumed
      var s:Sprite = new Sprite();
      s.addEventListener(Event.ENTER_FRAME, enterFrameListener);
      
      // Repeatedly create new objects, occupying system memory
      var timer:Timer = new Timer(1, 0);
      timer.addEventListener(TimerEvent.TIMER, timerListener);
      timer.start(); 
    }

    private function timerListener (e:TimerEvent):void {
      // Create an object to take up some system memory. Could be
      // any object, but TextField objects are nice and meaty.
      new TextField();
    }

    // This function is executed until the Sprite object is 
    // garbage collected
    private function enterFrameListener (e:Event):void {
      // Display the amount of memory occupied by this program
      trace("System memory used by this program: " + System.totalMemory);
    }
  }
}
