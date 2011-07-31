package {
  import flash.display.*;
  import flash.events.*;
  
  // When the user clicks an empty area of the Stage instance, this class
  // draws a randomly sized and colored circle. When the user clicks 
  // a circle, this class removes that circle from the screen.
  public class CircleClicker extends Sprite {
    public function CircleClicker () {
      stage.addEventListener(MouseEvent.CLICK, clickListener);
    }

    private function clickListener (e:MouseEvent):void {
      // If the event target is the Stage instance
      if (e.target == stage) {
        // ...draw a circle
        drawCircle(e.stageX, e.stageY);
      } else {
        // ... otherwise, the event target must be a Sprite object 
        // containing a circle, so remove it
        removeChild(DisplayObject(e.target));
      }
    }

    public function drawCircle (x:int, y:int):void {
      var randomColor:int = Math.floor(Math.random()*0xFFFFFF);
      var randomSize:int = 10 + Math.floor(Math.random()*150);
      var circle:Sprite = new Sprite()
      circle.graphics.beginFill(randomColor, 1);
      circle.graphics.lineStyle();
      circle.graphics.drawEllipse(0, 0,randomSize, randomSize);
      circle.x = x-randomSize/2;
      circle.y = y-randomSize/2;
      addChild(circle);
    }
  }
}

