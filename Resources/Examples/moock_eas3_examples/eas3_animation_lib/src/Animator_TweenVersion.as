package {
  import flash.display.*;
  import mx.effects.Tween;
  import mx.effects.easing.Linear;
  
  // This version of the Animator class uses the Flex framework's Tween 
  // class to perform animations
  public class Animator_TweenVersion {
    private var xTween:Tween;
    private var yTween:Tween;
    private var target:DisplayObject;

    public function Animator_TweenVersion (target:DisplayObject) {
      this.target = target;
    }    

    public function animateTo (toX:Number, toY:Number, 
                               duration:Number):void {
      if (xTween != null && yTween != null) {
        xTween.pause();
        yTween.pause();
      }
      xTween = new Tween(target, target.x, toX, duration);
      xTween.setTweenHandlers(xUpdate, xUpdate);
      yTween = new Tween(target, target.y, toY, duration);
      yTween.setTweenHandlers(yUpdate, yUpdate);
      xTween.easingFunction = Linear.easeNone;
      yTween.easingFunction = Linear.easeNone;
    }

    private function xUpdate (val:Number):void {
      target.x = val;
    }
    
    private function yUpdate (val:Number):void {
      target.y = val;
    }
  }
}