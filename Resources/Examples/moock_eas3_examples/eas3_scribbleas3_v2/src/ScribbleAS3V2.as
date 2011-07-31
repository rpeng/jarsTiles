package {
  import flash.display.*;
  import flash.events.*;
  import flash.ui.*;
  import flash.geom.*;
  
  // A basic drawing application. This version draws a bitmap line 
  // in a BitmapData object every time MouseEvent.MOUSE_MOVE occurs.
  // Line drawing is performed by a custom line drawing algorithm.
  public class ScribbleAS3V2 extends Sprite {
    private var canvas:Bitmap;
    private var canvasContainer:Sprite;
    private var border:Shape;
    private var isDrawing:Boolean = false;
    private var lastX:int;
    private var lastY:int;
    
    public function ScribbleAS3V2 () {
      createCanvas();
      registerForInputEvents();
     
      // Prevent the app from resizing.
      stage.scaleMode = StageScaleMode.NO_SCALE;
    }
    
    private function createCanvas (width:int = 200, height:int = 200):void {
      // Define the data object that will store the actual pixel 
      // data for the user's drawing
      var canvasData:BitmapData = new BitmapData(width, 
                                                 height, false, 0xFFFFFFFF);
      
      // Create a new displayable Bitmap, used to render the
      // canvasData object created in the preceding line
      canvas = new Bitmap(canvasData);
      
      // Create a Sprite to contain the Bitmap. The Bitmap class 
      // doesn't broadcast input events, so put it in a Sprite so the 
      // user can interact with it.
      canvasContainer = new Sprite();
      canvasContainer.addChild(canvas);
      
      // Add the canvasContainer Sprite (and the Bitmap it contains) to
      // the display list so it appears on screen.
      addChild(canvasContainer);
      
      // Put a border around the drawing surface. Keep the border in a
      // separate Sprite so that it doesn't trigger mouse interactivity.
      border = new Shape();
      border.graphics.lineStyle(1);
      border.graphics.drawRect(0, 0, width, height);
      addChild(border);
    }
    
    private function registerForInputEvents ():void {
      // Register for mouse down and movement events broadcast 
      // by the canvasContainer.
      canvasContainer.addEventListener(MouseEvent.MOUSE_DOWN, 
                                       mouseDownListener);
      canvasContainer.addEventListener(MouseEvent.MOUSE_MOVE,
                                       mouseMoveListener);

      // Register for mouse up and key events broadcast by the Stage (i.e., 
      // globally). Use the Stage because a mouse up event should always 
      // exit drawing mode, even if it occurs while the mouse pointer is not 
      // over the drawing. Likewise, the spacebar should always clear the 
      // drawing, even when canvasContainer isn't focussed. 
      stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
      stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
    }

    public function drawPoint (x:int, y:int, color:uint = 0xFF000000):void {
      // Set the color of the specified pixel.
      canvas.bitmapData.setPixel(x, y, color);
    }

    // Draws a non-antialiased line onto the BitmapData.
    // Thanks to David Brackeen for the line-plotting algorithm. 
    // See: http://www.brackeen.com/home/vga/ 
    public function drawLine (x1:int, y1:int, x2:int, y2:int, 
                              color:uint = 0xFF000000):void {

      var dx:int,dy:int,sdx:int,sdy:int,
          px:int,py:int,dxabs:int,dyabs:int,i:int;
      var slope:Number;

      dx    = x2-x1;      // The horizontal distance of the line
      dy    = y2-y1;      // The vertical distance of the line
      dxabs = Math.abs(dx);
      dyabs = Math.abs(dy);
      sdx   = signum(dx);
      sdy   = signum(dy);

      // If the line is more horizontal than vertical
      if (dxabs >= dyabs) {
        slope = dy/dx;
        for(i=0; i != dx; i += sdx) {
          px = x1 + i;       // Move along the line horizontally one pixel
          py = y1 + slope*i; // Find the y for this x. The decimal is
                             // auto-truncated because py's datatype is int.
          drawPoint(px, py, color);
        }
      // If the line is more vertical than horizontal
      } else {
        slope = dx/dy;
        for(i=0; i != dy; i += sdy) {
          py = y1 + i;       // Move along the line vertically one pixel
          px = x1 + slope*i; // Find the x for this y. The decimal is
                             // auto-truncated because py's datatype is int.
          drawPoint(px, py, color);
        }
      }
    }
    
    public function signum (n:int):int {
      if (n > 0) return 1;
      if (n < 0) return -1;
      return 0;
    }

    private function mouseDownListener (e:MouseEvent):void {
      isDrawing = true;
      lastX = int(e.localX);
      lastY = int(e.localY);
      // Draw a dot where the mouse was clicked
      drawPoint(lastX, lastY);
    }

    private function mouseMoveListener (e:MouseEvent):void {
      // Draw a line when the mouse moves over the drawing
      // while the primary mouse button is depressed
      if (isDrawing) {
        // Use localX and localY to obtain pointer position relative to 
        // the canvasContainer. The coordinates would be coerced to ints 
        // without the cast, but we cast for clarity. In practice, 
        // these mouse coordinates are always integers.
        var thisX:int = int(e.localX);
        var thisY:int = int(e.localY);
        
        // Draw a pixel-line to the new mouse location
        drawLine(lastX, lastY, thisX, thisY);
        
        // Remember the last mouse position for next time
        lastX = thisX;
        lastY = thisY;

        // Update the screen immediately following the execution of
        // this event listener function
        e.updateAfterEvent();
      }
    }

    private function mouseUpListener (e:MouseEvent):void {
      isDrawing = false;
    }

    private function keyDownListener (e:KeyboardEvent):void {
      // Clear the drawing when the spacebar is pressed
      if (e.charCode == Keyboard.SPACE) {
        canvas.bitmapData.fillRect(new Rectangle(0, 0, 
                                  canvas.width, canvas.height), 0xFFFFFFFF);
      }
    }
  }
}
