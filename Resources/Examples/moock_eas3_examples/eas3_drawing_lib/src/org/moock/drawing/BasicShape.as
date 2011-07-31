package org.moock.drawing {
  import flash.display.*;
  import flash.events.*;
  import flash.errors.IllegalOperationError;

  // Base class for displayable geometric shapes
  public class BasicShape extends Shape {
    // Fill style
    protected var fillColor:Number = 0xFFFFFF;
    protected var fillAlpha:Number = 1;
    
    // Line style. Use mitered joints instead of round (the ActionScript 
    // default). All other defaults match ActionScript's defaults.
    protected var lineThickness:Number = 1;
    protected var lineColor:uint = 0;
    protected var lineAlpha:Number = 1;
    protected var linePixelHinting:Boolean = false;
    protected var lineScaleMode:String = LineScaleMode.NORMAL;
    protected var lineJoints:String = JointStyle.MITER;  
    protected var lineMiterLimit:Number = 3;
    
    // Flag indicating that the object needs redrawing. Prevents this 
    // object from being redrawn in cases where some other object
    // triggers a RENDER event.
    protected var changed:Boolean = false;
    

    // Constructor
    public function BasicShape () {
      // Register to be notified when this object is added to or removed
      // from the display list (requires the custom helper class, 
      // StageDetector)
      var stageDetector:StageDetector = new StageDetector(this);
      stageDetector.addEventListener(StageDetector.ADDED_TO_STAGE, 
                                     addedToStageListener);
      stageDetector.addEventListener(StageDetector.REMOVED_FROM_STAGE,
                                     removedFromStageListener);
    }

    // Sets the visual characteristics of the line around the shape
    public function setStrokeStyle (thickness:Number = 1,
                                    color:uint = 0, 
                                    alpha:Number = 1, 
                                    pixelHinting:Boolean = false, 
                                    scaleMode:String = "normal", 
                                    joints:String = "miter", 
                                    miterLimit:Number = 10):void {
      lineThickness = thickness;
      lineColor = color;
      lineAlpha = alpha;
      linePixelHinting = pixelHinting;
      lineScaleMode = scaleMode;
      lineJoints = joints;
      lineMiterLimit = miterLimit;

      // The line style has changed, so ask to be notified of the
      // next screen update. At that time, redraw the shape.
      setChanged();
    }

    // Sets the visual characteristics of the shape's fill
    public function setFillStyle (color:uint = 0xFFFFFF, 
                                  alpha:Number = 1):void {
      fillColor = color;
      fillAlpha = alpha;

      // The fill style has changed, so ask to be notified of the
      // next screen update. At that time, redraw the shape.
      setChanged();
    }

    // Creates the shape's graphics, delegating specific line-drawing
    // operations to individual BasicShape subclasses. For the sake of
    // performance, draw() is called only when the stage broadcasts 
    // an Event.RENDER event.
    private function draw ():void {
      // Delete all graphics in this object.
      graphics.clear();
      // Line cap style doesn't matter for a 
      // closed shape, so pass null for that argument.
      graphics.lineStyle(lineThickness, lineColor, lineAlpha, 
                         linePixelHinting, lineScaleMode, null, 
                         lineJoints, lineMiterLimit);
      graphics.beginFill(fillColor, fillAlpha);
      drawShape();  // Call drawing routine, implemented by subclass
      graphics.endFill();
        
      // Make a note that the most recent changes have been rendered.
      clearChanged();
    }

    // Draws the actual lines for each type of shape. Must be implemented
    // by all BasicShape subclasses.
    protected function drawShape ():void {
      // Prevent this abstract-style method from being invoked directly
      throw new IllegalOperationError("The drawShape() method can be "
                            + "invoked on BasicShape subclasses only.")
    }

    // Notes that something about this shape has changed, if the shape
    // is currently on stage, causes it to be drawn at the next render
    // opportunity
    protected function setChanged ():void {
      changed = true;
      requestDraw();
    }

    // Notes that the most recent changes have been rendered
    protected function clearChanged ():void {
      changed = false;
    }

    // Indicates whether or not there are changes to this shape
    // that have not yet been rendered
    protected function hasChanged ():Boolean {
      return changed;
    }

    // If this shape is on screen, requestDraw() causes it to be drawn 
    // the next time the screen is updated
    protected  function requestDraw ():void {
      if (stage != null) {
        stage.invalidate();
      }
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
        requestDraw();
      }
    }

    // Event listener triggered when this shape 
    // is removed from the display list
    private function removedFromStageListener (e:Event):void {
      // No need to listen for Event.RENDER events when the object isn't
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
  }
}