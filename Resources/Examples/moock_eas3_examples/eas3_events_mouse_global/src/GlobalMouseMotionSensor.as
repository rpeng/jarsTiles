package {
  import flash.display.*;
  import flash.events.*;
  
  public class GlobalMouseMotionSensor extends Sprite {
    public function GlobalMouseMotionSensor () {
      stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener);
    }

    private function mouseMoveListener (e:MouseEvent):void {
      trace("The mouse moved.");
    }
  }
}
