package org.moock.drawing {
  import flash.display.*;
  import flash.events.*;
  
  public class RectangleV1 extends Shape {
    // Size
    private var w:Number;
    private var h:Number;
    
    // Fill style
    private var fillColor:Number = 0xFFFFFF;
    private var fillAlpha:int = 1;
    
    // Line style
    private var lineThickness:Number = 1;
    private var lineColor:uint = 0;
    private var lineAlpha:Number = 1;
    private var linePixelHinting:Boolean = false;
    private var lineScaleMode:String = LineScaleMode.NORMAL;
    private var lineJoints:String = JointStyle.MITER;
    private var lineMiterLimit:Number = 10;

    public function RectangleV1 (width:Number = 100, height:Number = 100) {
      setSize(width, height);
      addEventListener(Event.ADDED, addedListener);
    }

    public function draw ():void {
      graphics.clear();
      // Line cap style doesn't matter for a 
      // closed shape, so pass null for that argument.
      graphics.lineStyle(lineThickness, lineColor, lineAlpha, linePixelHinting, 
                         lineScaleMode, null, lineJoints, lineMiterLimit);
      graphics.beginFill(fillColor, fillAlpha);
      graphics.drawRect(0, 0, w, h);
      graphics.endFill();
    }
    
    public function setSize (newWidth:Number, newHeight:Number):void {
      w = newWidth;
      h = newHeight;
      
      if (stage != null) {
        stage.invalidate();
      }
    }  
    
    override public function set width (newWidth:Number):void {
      setSize(newWidth, h);
    }

    override public function get width ():Number {
      return w;
    }

    override public function set height (newHeight:Number):void {
      setSize(w, newHeight);
    }

    override public function get height ():Number {
      return h;
    }
      
    
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

      if (stage != null) {
        stage.invalidate();
      }
    }

    public function setFillStyle (color:uint = 0xFFFFFF, 
                                  alpha:Number = 1):void {
      fillColor = color;
      fillAlpha = alpha;

      if (stage != null) {
        stage.invalidate();
      }
    }

    private function addedListener (e:Event):void {
      stage.addEventListener(Event.RENDER, renderListener);
      stage.invalidate();
    }

    private function renderListener (e:Event):void {
      draw();
    }    
  }
}