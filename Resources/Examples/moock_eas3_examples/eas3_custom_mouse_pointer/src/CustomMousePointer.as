package {
  import flash.display.*;
  import flash.ui.*;
  import flash.events.*;
  import flash.geom.*;

  // A display class that replaces the mouse pointer with a new graphic.
  // When a CustomMousePointer object is added to the display list,
  // it automatically hides the system pointer and begins following
  // its location. When a CustomMousePointer object is removed from the 
  // display list, it automatically restores the system mouse pointer.
  public class CustomMousePointer extends Sprite {
    // Constructor
    public function CustomMousePointer () {
      // Create a blue triangle to use as the custom mouse pointer
      graphics.lineStyle(1);
      graphics.beginFill(0x0000FF, 1);
      graphics.lineTo(15, 5);
      graphics.lineTo(5, 15);
      graphics.lineTo(0, 0);
      graphics.endFill();

      // Register to be notified when this object is added to or removed
      // from the display list (requires the custom helper class, 
      // StageDetector)
      var stageDetector:StageDetector = new StageDetector(this);
      stageDetector.addEventListener(StageDetector.ADDED_TO_STAGE, 
                                     addedToStageListener);
      stageDetector.addEventListener(StageDetector.REMOVED_FROM_STAGE,
                                     removedFromStageListener);
    }

    // Handles StageDetector.ADDED_TO_STAGE events
    private function addedToStageListener (e:Event):void {
      // Hide the system mouse pointer
      Mouse.hide();

      // Register to be notified when the system mouse pointer moves
      // over, or leaves Flash Player's display area
      stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener);
      stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveListener);
    }

    // Handles StageDetector.REMOVED_FROM_STAGE events
    private function removedFromStageListener (e:Event):void {
      // Show the system mouse pointer
      Mouse.show();
      
      // Unregister for mouse events with the Stage instance
      stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener);
      stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveListener);
    }

    // Handles Event.MOUSE_LEAVE events    
    private function mouseLeaveListener (e:Event):void {
      // When the mouse leaves Flash Player's display area, hide the
      // custom pointer. Otherwise, the custom mouse pointer and the system 
      // mouse pointer will be shown on the screen at the same time.
      visible = false;
    }

    // Handles MouseEvent.MOUSE_MOVE events
    private function mouseMoveListener (e:MouseEvent):void {
      // When the mouse moves, update the position of the custom mouse 
      // pointer to match the position of the system mouse pointer
      var pointInParent:Point = parent.globalToLocal(new Point(e.stageX, 
                                                               e.stageY));
      x = pointInParent.x;
      y = pointInParent.y;
      
      // Request post-event screen update so that the animation of the
      // pointer is as smooth as possible
      e.updateAfterEvent();  

      // The MouseEvent.MOUSE_MOVE has fired, so the system pointer
      // must be within Flash Player's display area. Therefore, make sure
      // the custom mouse pointer is visible (it might have been hidden
      // because the system pointer left Flash Player's display area).
      // This code is unfortunate here--it rightfully belongs in an 
      // Event.MOUSE_ENTER event, but no such event exists in 
      // Flash Player 9.
      if (!visible) {
        visible = true;  
      }
    }
  }
}