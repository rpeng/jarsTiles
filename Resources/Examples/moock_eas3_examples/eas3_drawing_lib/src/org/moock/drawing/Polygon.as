package org.moock.drawing {
  // Represents a polygon that can be drawn to the screen
  public class Polygon extends BasicShape {
    // The polygon's points.
    //  To reduce memory consumption, the points are stored in two integer 
    //  arrays rather than one array of flash.geom.Point objects.
    private var xpoints:Array;
    private var ypoints:Array;
    
    // Constructor
    public function Polygon (xpoints:Array = null, ypoints:Array = null) {
      super();
      setPoints(xpoints, ypoints);
    }

    // The polygon drawing routine
    override protected function drawShape ():void { 
      // Draw lines to each point in the polygon
      graphics.moveTo(xpoints[0], ypoints[0]);
      for (var i:int = 1; i < xpoints.length; i++) {
        graphics.lineTo(xpoints[i], ypoints[i]);
      }
      // Close the shape by returning to the first point
      graphics.lineTo(xpoints[0], ypoints[0]);
    }
    
    // Assigns the polygon's points
    public function setPoints (newXPoints:Array, newYPoints:Array):void {
      if (newXPoints == null || newYPoints == null) {
        return;
      }
      
      if (newXPoints.length != newYPoints.length) {
        throw new Error("setPoints() requires a matching " 
                        + "number of x and y points");
      }
      
      xpoints = newXPoints;
      ypoints = newYPoints;
      
      // Assigning new points to the polygon changes its shape, 
      // so it must be redrawn at the next render opportunity.
      setChanged();
    }  
  }
}