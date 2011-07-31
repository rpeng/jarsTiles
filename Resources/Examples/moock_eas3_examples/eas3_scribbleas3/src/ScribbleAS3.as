package {
  import flash.display.*;
  import flash.events.*;
  import flash.ui.*;
  import flash.geom.*;

  // A basic drawing application. Draws a single dot on a
  // BitmapData object every time the MouseEvent.MOUSE_MOVE event 
  // occurs while the primary mouse button is depressed.
  public class ScribbleAS3 extends Sprite {
    // The on-screen bitmap
    private var canvas:Bitmap;  
    // Contains the bitmap, providing interactivity
    private var canvasContainer:Sprite;  
    // Line around the bitmap
    private var border:Shape;  
    // Indicates whether the mouse is currently depressed
    private var isDrawing:Boolean = false;  
    
    // Constructor
    public function ScribbleAS3 () {
      createCanvas();
      registerForInputEvents();
     
      // Prevent the app from resizing
      stage.scaleMode = StageScaleMode.NO_SCALE;
    }
    
    // Creates the empty bitmap object where drawing will occur
    private function createCanvas (width:int = 200, height:int = 200):void {
      // Define the BitmapData object that will store the pixel 
      // data for the user's drawing
      var canvasData:BitmapData = new BitmapData(width, height, 
                                                 false, 0xFFFFFFFF);
      
      // Create a new displayable Bitmap, used to render the
      // canvasData object
      canvas = new Bitmap(canvasData);
      
      // Create a Sprite to contain the Bitmap. The Bitmap class doesn't
      // support input events; hence, put it in a Sprite so the user 
      // interact with it.
      canvasContainer = new Sprite();
      // Add the canvas bitmap to the canvasContainer Sprite
      canvasContainer.addChild(canvas);
      
      // Add the canvasContainer Sprite (and the Bitmap it contains) to
      // this object's display hierarchy
      addChild(canvasContainer);

      // Make a border around the drawing surface
      border = new Shape();
      border.graphics.lineStyle(1, 0xFF000000);
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

    // Sets the color of a specified pixel
    public function drawPoint (x:int, y:int, color:uint = 0xFF000000):void {
      canvas.bitmapData.setPixel32(x, y, color);
    }

    // Responds to MouseEvent.MOUSE_DOWN events
    private function mouseDownListener (e:MouseEvent):void {
      // Set a flag indicating that the primary 
      // mouse button is currently down
      isDrawing = true;
      // Draw a dot where the mouse was clicked. 
      drawPoint(e.localX, e.localY);
    }

    // Responds to MouseEvent.MOUSE_MOVE events
    private function mouseMoveListener (e:MouseEvent):void {
      // Draw a dot when the mouse moves over the drawing
      // while the primary mouse button is depressed
      if (isDrawing) {
        // Use localX and localY to obtain pointer position relative to 
        // the canvasContainer.
        drawPoint(e.localX, e.localY);
        
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
