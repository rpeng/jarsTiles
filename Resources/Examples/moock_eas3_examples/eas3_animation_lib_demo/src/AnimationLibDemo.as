package {
  import flash.display.*;
  import flash.events.*;
  import flash.text.*;
  import flash.geom.Point;

  // Demonstrates the use of the Animator class
  public class AnimationLibDemo extends Sprite {
    private var circleAnimator:Animator;
    
    public function AnimationLibDemo () {
      // Create a message that animates to position (300, 0) over
      // the course of one second (1000 ms)
      var welcome:SlidingText = new SlidingText(300, 0, 1000);
      welcome.text       = "Welcome!";
      welcome.autoSize   = TextFieldAutoSize.LEFT;
      addChild(welcome);

      // Create a circle to animate
      var circle:Shape = new Shape();
      circle.graphics.lineStyle(10, 0x666666);
      circle.graphics.beginFill(0x999999);
      circle.graphics.drawCircle(0, 0, 25);
      addChild(circle);
      
      // Create an Animator to animate the circle
      circleAnimator = new Animator(circle);
      
      // Register for mouse clicks
      stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
    }

    // When the user clicks the stage, animate the 
    // circle to the point that was clicked.
    private function mouseDownListener (e:MouseEvent):void {
      var mousePt:Point = globalToLocal(new Point(e.stageX, e.stageY));
      circleAnimator.animateTo(mousePt.x, mousePt.y, 500);
    }
  }
}
