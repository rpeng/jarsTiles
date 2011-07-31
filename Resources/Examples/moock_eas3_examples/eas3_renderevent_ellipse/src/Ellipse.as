package {
  import flash.display.Shape;
  import flash.events.*;

  public class Ellipse extends Shape {
    private var w:Number;
    private var h:Number;
    private var changed:Boolean;
    
    public function Ellipse (width:Number, height:Number) {
      // Register for notification when this 
      // object is added to, or removed from, the display list
      var stageDetector:StageDetector = new StageDetector(this);
      stageDetector.addEventListener(StageDetector.ADDED_TO_STAGE, 
                                     addedToStageListener);
      stageDetector.addEventListener(StageDetector.REMOVED_FROM_STAGE,
                                     removedFromStageListener);

      // Set the width and height
      w = width;
      h = height;
      
      // Note that the object has changed
      setChanged();
    }

    public function setWidth (newWidth:Number):void {
      w = newWidth;
      setChanged();
    }

    public function getWidth ():Number {
      return w;
    }

    public function setHeight (newHeight:Number):void {
      h = newHeight;
      setChanged();
    }

    public function getHeight ():Number {
      return h;
    }

    // Notes that something about this shape has changed
    private function setChanged ():void {
      changed = true;
      if (stage != null) {
        stage.invalidate();
      }
    }

    // Notes that the most recent changes have been rendered
    private function clearChanged ():void {
      changed = false;
    }
    
    // Indicates whether or not there are changes to this shape
    // that have not yet been rendered
    private function hasChanged ():Boolean {
      return changed;
    }

    // Event listener triggered when this shape is added to the display list
    private function addedToStageListener (e:Event):void {
      // Register to be notified of screen updates
      stage.addEventListener(Event.RENDER, renderListener);

      // If the object was changed while off the display list, 
      // draw those changes at the next render opportunity. But if the 
      // object hasn't changed since the last time it was on the display 
      // list, then there's no need to draw it.
      if (hasChanged()) {
        stage.invalidate();
      }
    }

    // Event listener triggered when this shape 
    // is removed from the display list
    private function removedFromStageListener (e:Event):void {
      // No need to receive screen-update events when the object isn't
      // on the display list
      stage.removeEventListener(Event.RENDER, renderListener);
    }

    // Event listener triggered when the screen is about to be updated and
    // stage.invalidate() has been called.
    private function renderListener (e:Event):void {
      // Call draw if there are unrendered changes to this shape.
      // If another object triggers a render event, but this object hasn't
      // changed, then this object won't be redrawn.
      if (hasChanged()) {
        draw();
      }
    }  

    private function draw ():void {
      graphics.clear();
      graphics.lineStyle(1);
      graphics.beginFill(0xFFFFFF, 1);
      graphics.drawEllipse(0, 0, w, h);
    }
  }
}
