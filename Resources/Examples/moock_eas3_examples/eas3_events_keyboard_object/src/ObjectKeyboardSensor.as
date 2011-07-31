package {
  import flash.display.*;
  import flash.events.*;
  
  // Demonstrates how to handle keyboard events for a single object.
  // Creates two rectangles, rect1 and rect2. When rect1 is focused
  // and a key is pressed, moves rect1 to the right. When rect2 is focused
  // and a key is pressed, rotates rect2.
  public class ObjectKeyboardSensor extends Sprite {
    public function ObjectKeyboardSensor () {
      // Create the rectangles
      var rect1:Sprite = new Sprite();
      
var r:Sprite = new Sprite();
rect1.addChild(r);
r.graphics.lineStyle(1);
r.graphics.beginFill(0x0000FF);
r.graphics.drawRect(0, 0, 150, 75);
var r2:Sprite = new Sprite();
rect1.addChild(r2);
r2.x = 50;
r2.graphics.lineStyle(1);
r2.graphics.beginFill(0x0000FF);
r2.graphics.drawRect(0, 0, 150, 75);

rect1.y = 200;

//     rect1.buttonMode = true;
     rect1.tabEnabled = true;
//     rect1.mouseChildren = false;
//     rect1.tabChildren = true;
//   rect1.tabIndex = 3

      
//      rect1.graphics.lineStyle(1);
//      rect1.graphics.beginFill(0x0000FF);
//      rect1.graphics.drawRect(0, 0, 75, 75);
//      rect1.tabEnabled = true;

      var rect2:Sprite = new Sprite();
      rect2.graphics.lineStyle(1);
      rect2.graphics.beginFill(0x0000FF);
      rect2.graphics.drawRect(0, 0, 75, 75);
      rect2.x = 200;
      rect2.tabEnabled = true;
      
      // Add the rectangles to the display list
      addChild(rect1);
      addChild(rect2);
      
      // Register rectangles for keyboard events
      rect1.addEventListener(KeyboardEvent.KEY_DOWN, rect1KeyDownListener);
      rect2.addEventListener(KeyboardEvent.KEY_DOWN, rect2KeyDownListener);
    }
 
    // Executed when rect1 has focus and a key is pressed
    private function rect1KeyDownListener (e:KeyboardEvent):void {
      Sprite(e.target).x += 10;
    }

    // Executed when rect2 has focus and a key is pressed
    private function rect2KeyDownListener (e:KeyboardEvent):void {
      Sprite(e.target).rotation += 10;
    }
  }
}

