package {
  import flash.display.*;
  import flash.events.*;
  
  // Demonstrates how to handle keyboard events from a global 
  // point of reference. Displays a debugging message when a key is pressed
  // while Flash Player has system focus.
  public class GlobalKeyboardSensor  extends Sprite {
    public function GlobalKeyboardSensor  () {
      stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
    }

    private function keyDownListener (e:KeyboardEvent):void {
      trace("A key was pressed.");
      
    }
  }
}

