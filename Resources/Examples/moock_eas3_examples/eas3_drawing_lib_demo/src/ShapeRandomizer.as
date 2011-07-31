package {
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  
  import org.moock.drawing.*;
  
  // An org.moock.drawing library demo. Creates random shapes when the
  // mouse clicks the stage.
  public class ShapeRandomizer extends Sprite {
    
    // The shapes
    private var rect:Rectangle;
    private var ell:Ellipse;
    private var poly:Polygon;
    private var star:Star;
    
    // Constructor
    public function ShapeRandomizer () {
      // Create a rectangle
      rect = new Rectangle(50, 100);
      rect.setStrokeStyle(1, 0xFF0000);
      rect.setFillStyle(0x0000FF);

      // Create an ellipse
      ell = new Ellipse(250, 50);
      ell.setStrokeStyle(2, 0xFFFF00);
      ell.setFillStyle(0xED994F);

      // Create a triangle (i.e., a 3-sided Polygon)
      poly = new Polygon([0, 50, 100], [50, 0, 50]);
      poly.setStrokeStyle(4, 0x333333);
      poly.setFillStyle(0x00FF00);

      // Create a star
      star = new Star(5, 30, 80);
      star.setStrokeStyle(4, 0x666666);
      star.setFillStyle(0xFF0000);
     
      // Add the shapes to the display list
      addChild(rect);
      addChild(ell);
      addChild(poly);
      addChild(star);

      // Register for mouse clicks
      stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
    }

    // Event listener triggered when the mouse clicks Flash Player's
    // display area
    private function mouseDownListener (e:MouseEvent):void {
      // Randomly change the shapes
      rect.width  = random(1, 300);
      rect.height = random(1, 300);
      rect.setStrokeStyle(random(1, 10), random(0, 0xFFFFFF));
      rect.setFillStyle(random(0, 0xFFFFFF), Math.random());

      ell.width  = random(1, 300);
      ell.height = random(1, 300);
      ell.setStrokeStyle(random(1, 10), random(0, 0xFFFFFF));
      ell.setFillStyle(random(0, 0xFFFFFF), Math.random());

      poly.setPoints([random(1, 300), random(1, 300), random(1, 300)],
                  [random(1, 300), random(1, 300), random(1, 300)]);
      poly.setStrokeStyle(random(1, 10), random(0, 0xFFFFFF));
      poly.setFillStyle(random(0, 0xFFFFFF), Math.random());

      star.setStar(random(3, 15), random(10, 20), random(30, 80));
      star.setStrokeStyle(random(1, 10), random(0, 0xFFFFFF));
      star.setFillStyle(random(0, 0xFFFFFF), Math.random());
    }

    // Returns a number in the range of minVal to maxVal, inclusive
    public function random (minVal:int, maxVal:int):int {
      return minVal + Math.floor(Math.random() * (maxVal + 1 - minVal));
    }
  }
}
