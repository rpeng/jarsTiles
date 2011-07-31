package {
  import flash.display.*;
  import flash.events.*;
  import flash.ui.*;
  import flash.geom.*;

  // A basic drawing application. This version draws a vector off screen
  // and then copies that vector to a bitmap surface, thus avoiding
  // the performance degradation associated with drawing too many vectors.
  public class ScribbleAS3_VectorV2 extends Sprite {
    private var canvas:Bitmap;;           // The on-screen bitmap canvas
    private var virtualCanvas:Shape;      // The off-screen vector canvas
    private var canvasContainer:Sprite;   // Contains the bitmap,
                                          // providing interactivity
    private var isDrawing:Boolean = false;  // Indicates whether the mouse 
                                            // is currently depressed
    private var border:Shape; // Line around the bitmap
    private var lastX:int;    // Most recently clicked x-position
    private var lastY:int;    // Most recently clicked y-position
    
    // Constructor
    public function ScribbleAS3_VectorV2 () {
      createCanvas();
      registerForInputEvents();
     
      // Prevent the app from resizing.
      stage.scaleMode = StageScaleMode.NO_SCALE;
    }

    // Creates the on-screen bitmap canvas and off-screen vector canvas    
    private function createCanvas (width:int = 200, height:int = 200):void {
      // Create a new off-screen object into which individual 
      // vector lines are drawn before being copied to canvasData
      virtualCanvas = new Shape();
      
      // Define the data object that will store the actual pixel 
      // data for the user's drawing. Lines are copied from virtualCanvas
      // to this object.
      var canvasData:BitmapData = new BitmapData(width, 
                                                 height, false, 0xFFFFFFFF);
      
      // Create a new displayable Bitmap, used to render the
      // canvasData object
      canvas = new Bitmap(canvasData);
      
      // Create a Sprite to contain the Bitmap. The Bitmap class 
      // doesn't broadcast input events, so put it in a Sprite so the 
      // user can interact with it.
      canvasContainer = new Sprite();
      canvasContainer.addChild(canvas);
      
      // Add the canvasContainer Sprite (and the Bitmap it contains) to
      // this object's display hierarchy
      addChild(canvasContainer);

      // Put a border around the drawing surface.
      border = new Shape();
      border.graphics.lineStyle(1);
      border.graphics.drawRect(0, 0, width, height);
      addChild(border);
    }

    // Registers for the required mouse and keyboard events    
    private function registerForInputEvents ():void {
      // Register for mouse down and movement events from canvasContainer
      canvasContainer.addEventListener(MouseEvent.MOUSE_DOWN, 
                                       mouseDownListener);
      canvasContainer.addEventListener(MouseEvent.MOUSE_MOVE,
                                       mouseMoveListener);

      // Register for mouse up and key events from the Stage (i.e., 
      // globally). Use the Stage because a mouse up event should always 
      // exit drawing mode, even if it occurs while the mouse pointer is 
      // not over the drawing. Likewise, the spacebar should always clear 
      // the drawing, even when canvasContainer isn't focused. 
      stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
      stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
    }

    // Sets the color of a specified pixel. Use this for drawing a single
    // pixel because Graphics.lineTo() won't draw a single pixel
    public function drawPoint (x:int, y:int, color:uint = 0xFF000000):void {
      // Set the color of the specified pixel
      canvas.bitmapData.setPixel(x, y, color);
    }

    // Draws a vector line in virtualCanvas, then copies that line's bitmap 
    // representation to canvasData (which is accessed via
    // canvas.bitmapData)
    public function drawLine (x1:int, y1:int, x2:int, y2:int, 
                              color:uint = 0xFF000000):void {
      // Draw line in virtualCanvas
      virtualCanvas.graphics.clear(); 
      virtualCanvas.graphics.lineStyle(1, 0x000000, 1, true, 
                                      LineScaleMode.NORMAL, CapsStyle.NONE);
      virtualCanvas.graphics.moveTo(x1, y1);
      virtualCanvas.graphics.lineTo(x2, y2);
      // Copy line to canvasData 
      canvas.bitmapData.draw(virtualCanvas);
    }

    // Responds to MouseEvent.MOUSE_DOWN events
    private function mouseDownListener (e:MouseEvent):void {
      // Set a flag indicating that the primary 
      // mouse button is currently down
      isDrawing = true;
      // Remember the point clicked so we can draw a line to it if
      // the mouse moves
      lastX = e.localX;
      lastY = e.localY;
      // Draw a dot where the mouse was clicked
      drawPoint(e.localX, e.localY);
    }

    // Responds to MouseEvent.MOUSE_MOVE events
    private function mouseMoveListener (e:MouseEvent):void {
      // Draw a line when the mouse moves over the drawing
      // while the primary mouse button is depressed
      if (isDrawing) {
        // Use localX and localY to obtain pointer position relative to 
        // the canvasContainer.
        var thisX:int = e.localX;
        var thisY:int = e.localY;
        
        // Draw a line to the new mouse location
        drawLine(lastX, lastY, thisX, thisY);
        
        // Remember the last mouse position for next time
        lastX = thisX;
        lastY = thisY;
        
        // Update the screen immediately following the execution of
        // this event listener function
        e.updateAfterEvent();
      }
    }

    // Responds to MouseEvent.MOUSE_UP events    
    private function mouseUpListener (e:MouseEvent):void {
      // Set a flag indicating that the primary mouse button is currently up
      isDrawing = false;
    }

    // Responds to KeyboardEvent.KEY_DOWN events
    private function keyDownListener (e:KeyboardEvent):void {
      // Clear the drawing when the spacebar is pressed. To clear the
      // drawing, we set all pixels to the color white.
      if (e.charCode == Keyboard.SPACE) {
        canvas.bitmapData.fillRect(new Rectangle(0, 0, 
                                               canvas.width, canvas.height),
                                   0xFFFFFFFF);
      }
    }
  }
}
