package org.moock.drawing {
  // Represents a star shape that can be drawn to the screen
  public class Star extends Polygon {
    // Constructor
    public function Star (numTips:int, 
                          innerRadius:Number, 
                          outerRadius:Number,
                          angle:Number = 0) {
      super();
      setStar(numTips, innerRadius, outerRadius, angle);
    }

    // Sets the physical characteristics of the star.
    // Based on Ric Ewing's ActionScript 1.0 drawing methods, available at:
    // http://www.macromedia.com/devnet/flash/articles/adv_draw_methods.html
    //   numTips      Number of tips (must be 3 or more)
    //   innerRadius  Radius of the base of the tips
    //   outerRadius  Radius of the summit of the tips
    //   angle        Starting angle in degrees (defaults to 0)
    public function setStar (numTips:int, 
                             innerRadius:Number, 
                             outerRadius:Number,
                             angle:Number = 0):void {
      // Calculate the polygon points of the star
      if (numTips > 2) {
        // Initialize variables
        var pointsX:Array = [];
        var pointsY:Array = [];
        var centerX:Number = outerRadius;
        var centerY:Number = outerRadius;
        var step:Number, halfStep:Number,
            startAngle:Number, dx:Number, dy:Number;
        // Calculate distance between tips
        step = (Math.PI*2)/numTips;
        halfStep = step/2;
        // Calculate starting angle in radians
        startAngle = (angle/180)*Math.PI;
        // Set starting point
        pointsX[0] = centerX+(Math.cos(startAngle)*outerRadius);
        pointsY[0] = centerY-(Math.sin(startAngle)*outerRadius);
        // Add remaining points
        for (var i:int=1; i <= numTips; i++) {
          dx = centerX+Math.cos(startAngle+(step*i)-halfStep)*innerRadius;
          dy = centerY-Math.sin(startAngle+(step*i)-halfStep)*innerRadius;
          pointsX.push(dx);
          pointsY.push(dy);
          dx = centerX+Math.cos(startAngle+(step*i))*outerRadius;
          dy = centerY-Math.sin(startAngle+(step*i))*outerRadius;
          pointsX.push(dx);
          pointsY.push(dy);
        }
        // Store the star's calculated points
        setPoints(pointsX,pointsY);
      }
    }
  }
}