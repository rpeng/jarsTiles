package {
  import flash.display.*;
  import flash.events.*;
  import flash.ui.*;
  import flash.geom.*;

  // A basic drawing application. This version draws a vector line in a
  // Sprite object every time MouseEvent.MOUSE_MOVE occurs. The vector
  // version yields smooth lines (i.e., non-pixelated) when zoomed,
  // but at 100% lines can appear blurry due to antialiasing. Eventually, 
  // after enough vectors are drawn, performance will degrade.
  public class ScribbleAS3_Vector extends Sprite {
    private var canvas:Sprite;  // The drawing canvas
    private var border:Shape;   // Line around the drawing canvas

    private var isDrawing:Boolean = false;
    
    public function ScribbleAS3_Vector () {
      initCanvas();
      registerForInputEvents();
     
      // Prevent the app from resizing
      stage.scaleMode = StageScaleMode.NO_SCALE;
    }
    
    // Creates or resets the drawing canvas.
    private function initCanvas (width:int = 200, height:int = 200):void {
      // Create the canvas Sprite if it doesn't exist already
      if (canvas == null) {
        canvas = new Sprite();
        // Add canvas to the display list so it appears on screen
        addChild(canvas);

        // Put a border around the drawing surface. Keep the border in a
        // separate Sprite so that it doesn't trigger mouse interactivity.
        border = new Shape();
        border.graphics.lineStyle(1);
        border.graphics.drawRect(0, 0, width, height);
        addChild(border);  
      }

      // Clears the drawings on the canvas
      canvas.graphics.clear();
      canvas.graphics.beginFill(0xFFFFFF);
      canvas.graphics.drawRect(0, 0, width, height);
      canvas.graphics.endFill();  // ##[shouldn't be required. see bug 161829]
      
      // Make the line as crisp as possible. (But some antialiasing will
      // still be applied. There is no way to completely remove antialiasing
      // on lines drawn with the Graphics class.) ## [file ecr]
      canvas.graphics.lineStyle(0, 0, 1, true, 
                                LineScaleMode.NORMAL, CapsStyle.NONE);
    }

    private function registerForInputEvents ():void {
      // Register with the canvas for mouse down and move events
      canvas.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
      canvas.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener);

      // Register for mouse up and key events broadcast by the Stage 
      // (i.e., globally). Use the Stage because a mouse up event should 
      // always exit drawing mode, even if it occurs while the mouse 
      // pointer is not over the drawing. Likewise, the spacebar should 
      // always clear the drawing, even when the canvas isn't focussed. 
      stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
      stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
    }

    private function mouseDownListener (e:MouseEvent):void {
      isDrawing = true;
      // Note: can't draw a single-dot for the mouse click in the vector
      // version. Vectors have to be more than one pixel long, and a single-
      // pixel rectangle looks blurry. So just move the pen to the 
      // click position.
      canvas.graphics.moveTo(int(e.localX), int(e.localY));
    }

    private function mouseMoveListener (e:MouseEvent):void {
      // Draw a line when the mouse moves over the drawing
      // while the primary mouse button is depressed
      if (isDrawing) {
        // Use localX and localY to obtain pointer position relative to 
        // the canvasContainer
        canvas.graphics.lineTo(int(e.localX), int(e.localY));

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
        initCanvas();
      }
    }
  }
}
