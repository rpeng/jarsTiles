package {
  import flash.display.*;
  import flash.events.*;

  // Positions a Sprite object, rect, in the top-right corner of Flash 
  // Player’s display area every time Flash Player is resized
  public class StretchyLayout extends Sprite {
    private var rect:Sprite;
    public function StretchyLayout () {
      // Create a rectangle graphic and add it to the display list
      rect = new Sprite();
      rect.graphics.lineStyle();
      rect.graphics.beginFill(0x0000FF);
      rect.graphics.drawRect(0, 0, 150, 75);
      addChild(rect);

      // Prevent content scaling
      stage.scaleMode = StageScaleMode.NO_SCALE;
      // Position the .swf file at the top-left corner of Flash Player's
      // display area
      stage.align     = StageAlign.TOP_LEFT;
      // Register for Event.RESIZE events
      stage.addEventListener(Event.RESIZE, resizeListener);

      // Manually trigger initial layout code
      positionRectangle();
    }

    // Handles Event.RESIZE events
    private function resizeListener (e:Event):void {
      positionRectangle();
    }

    // Positions rect in top-right corner of Flash Player's display area
    private function positionRectangle ():void {
      rect.x = stage.stageWidth - rect.width;
      rect.y = 0;
    }
  }
}
