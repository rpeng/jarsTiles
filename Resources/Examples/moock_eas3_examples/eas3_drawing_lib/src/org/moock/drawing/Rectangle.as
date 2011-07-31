package org.moock.drawing {
  // Represents a rectangle that can be drawn to the screen
  public class Rectangle extends Polygon {
    // The width and height of the rectangle
    protected var w:Number;
    protected var h:Number;

    // Constructor
    public function Rectangle (width:Number = 100, height:Number = 100) {
      super();
      setSize(width, height);
    }
   
    // Sets the width and height of the rectangle
    public function setSize (newWidth:Number, newHeight:Number):void {
      w = newWidth;
      h = newHeight;

      // Translate the width and height into points on the polygon
      setPoints([0,w,w,0],[0,0,h,h]);
    }  
  }
}