package take2 {
  import flash.display.*;
  import flash.net.URLRequest;
  import flash.geom.Rectangle;

  public class ImageViewer extends Sprite {
    // Loader object. Visual asset used to load image.
    private var imgLoader:Loader;

    // Border shape. Visual asset to be added to display list.
    private var border:Shape = null;

    // Border style.
    private var borderThickness:Number;
    private var borderColor:Number;

    // Outer dimensions of entire viewer (including border).
    private var w:Number;
    private var h:Number;

    // Constructor
    public function ImageViewer (x:Number = 0, 
                                 y:Number = 0, 
                                 w:Number = 0, 
                                 h:Number = 0, 
                                 borderThickness:Number = 1,
                                 borderColor:Number = 0) {
      this.borderThickness = borderThickness;
      this.borderColor = borderColor;
	    
      buildViewer();
      setPosition(x, y);
      setSize(w, h);
		}

    public function loadImage (URL:String):void {
      imgLoader.load(new URLRequest(URL));
    }

    public function setPosition (x:Number, y:Number):void {
      this.x = x;
      this.y = y;
      // No need to redraw because setting x and y 
      // automatically causes a screen update.
    }

    public function setSize (w:Number, h:Number):void {
      this.w = w;
      this.h = h;
      draw();
    }

    private function buildViewer ():void {
      createLoader();
      createBorder();
    }
	  
    private function createLoader ():void {
      // Create the Loader instance and make it a child of this object.
      imgLoader = new Loader();
      addChild(imgLoader);
    }

    private function createBorder ():void {
      // Create the Loader instance and make it a child of this object.
      border = new Shape();
      addChild(border);
    }

    private function draw ():void {
      // Only clip image and draw border if 
      // a width and height have been specified.
      if (w > 0 && h > 0) {
        // Size and position the loader.
        imgLoader.scrollRect = new Rectangle(0, 
                                             0, 
                                             w-borderThickness*2, 
                                             h-borderThickness*2);
        imgLoader.x = imgLoader.y = borderThickness;
      
        // Draw the border.
        var g:Graphics = border.graphics;
        g.clear();
        g.lineStyle(borderThickness, borderColor);
        g.drawRect(borderThickness/2, borderThickness/2,
                   w-borderThickness, h-borderThickness);
      }
    }
  }
}









