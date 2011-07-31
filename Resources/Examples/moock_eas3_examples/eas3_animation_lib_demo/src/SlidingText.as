package {
  import flash.text.*;

  public class SlidingText extends TextField {
    private var animator:Animator;
 
    public function SlidingText (toX:Number, toY:Number, duration:Number) {
      animator = new Animator(this);
      slideTo(toX, toY, duration);
    }

    public function slideTo (toX:Number, toY:Number, duration:Number):void {
      animator.animateTo(toX, toY, duration);
    }    
  }
}