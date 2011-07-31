package {
  import flash.display.*;
  import flash.text.TextField;
  
  public class GreetingApp extends Sprite {
    public function GreetingApp() {
      // Create a rectangle
      var rect:Shape = new Shape();
      rect.graphics.lineStyle(1);
      rect.graphics.beginFill(0x0000FF, 1);
      rect.graphics.drawRect(0, 0, 75, 50);

      // Create a circle
      var circle:Shape = new Shape();
      circle.graphics.lineStyle(1);
      circle.graphics.beginFill(0xFF0000, 1);
      circle.graphics.drawCircle(0, 0, 25);
      circle.x = 75;
      circle.y = 35;

      // Create a text message
      var greeting_txt:TextField = new TextField();
      greeting_txt.text = "Hello world";
      greeting_txt.x = 60;
      greeting_txt.y = 25;
      
      // Add assets to the display list
      addChild(greeting_txt);  // Depth 0
      addChild(circle);        // Depth 1
      addChild(rect);          // Depth 2

      // Create a triangle
      var triangle:Shape = new Shape();
      triangle.graphics.lineStyle(1);
      triangle.graphics.beginFill(0x00FF00, 1);
      triangle.graphics.moveTo(25, 0);
      triangle.graphics.lineTo(50, 25);
      triangle.graphics.lineTo(0, 25);
      triangle.graphics.lineTo(25, 0);
      triangle.graphics.endFill();
      triangle.x = 70;
      triangle.y = 8;

      // Put the triangle beneath the circle.
      addChildAt(triangle, getChildIndex(circle));
    }
  }
}
