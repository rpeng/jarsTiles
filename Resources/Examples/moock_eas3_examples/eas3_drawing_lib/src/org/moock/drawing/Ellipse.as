package org.moock.drawing {
  // Represents an ellipse that can be drawn to the screen
  public class Ellipse extends BasicShape {
    // The width and height of the ellipse
    protected var w:Number;
    protected var h:Number;
    
    // Constructor
    public function Ellipse (width:Number = 100, height:Number = 100) {
      super();
      setSize(width, height);
    }

    // The ellipse drawing routine
    override protected function drawShape ():void { 
      graphics.drawEllipse(0, 0, w, h);
    }
    
    // Sets the width and height of the ellipse
    public function setSize (newWidth:Number, newHeight:Number):void {
      w = newWidth;
      h = newHeight;

      // Setting the width and height of the ellipse changes its shape, 
      // so it must be redrawn at the next render opportunity.
      setChanged();
    }  
  }
}