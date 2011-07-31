package take4 {
  import flash.display.*;
  import flash.events.*;
  import flash.geom.Point;
  import flash.geom.Rectangle;

  public class DragManager {
    private var target:InteractiveObject;
    private var origTargetW:Number;
    private var origTargetH:Number;
    private var activated:Boolean;
    private var doClip:Boolean = false;

    private var leftBoundary:Number = 0;
    private var rightBoundary:Number = 0;
    private var topBoundary:Number = 0;
    private var bottomBoundary:Number = 0;
    private var useBounds:Boolean = false;

    // The offset of the displayed image.
    private var targetOffset:Point = new Point(0, 0);
    
    // Flag that indicates whether mouse button is depressed or not.
    private var mouseIsDown:Boolean = false;

    // Last recorded mouse position with mouse button depressed.
    private var lastMousePos:Point = new Point(0, 0);
    
    public function DragManager (target:InteractiveObject) {
      this.target = target;
    }

    public function activate ():void {
      // This condition checks to see if the target is currently "on-stage".
      if (target.stage == null) {
        return; // Could throw an error here (can't activate dragging 
                // for off-stage objects)
      }
      registerForMouseEvents();
      activated = true;
    }
    
    public function deactivate ():void {
      if (!activated) {
        return; // Could throw an error here (can't deactivate if not
                // already activated)
      }
      unRegisterForMouseEvents();
      activated = false;
    }

    // Specified bounds must be in target's parent's coord space.
    public function setBounds (l:Number, t:Number, r:Number, b:Number):void {
      useBounds = true;
      leftBoundary   = l;
      topBoundary    = t;
      rightBoundary  = r;
      bottomBoundary = b;
    }
    
    public function clearBounds ():void {
      useBounds = false;
      leftBoundary = topBoundary = bottomBoundary = rightBoundary = 0;
    }

    public function enableClipping ():void {
      if ((target.width < rightBoundary) || (target.height < bottomBoundary)) {
        return; // Could throw an exception here
      }
      doClip = true;
      origTargetW = target.width;
      origTargetH = target.height;
      target.scrollRect = new Rectangle(targetOffset.x, 
                                        targetOffset.y,
                                        rightBoundary,
                                        bottomBoundary);
    }
    
    public function disableClipping ():void {
      doClip = false;
      targetOffset.x = 0;
      targetOffset.y = 0;
      target.scrollRect = null;
    }

    private function registerForMouseEvents ():void {
      // If stage is null the target is not on the display list.
      if (target.stage == null) {
        return;
      }

      // You can register for MOUSE_DOWN even when target isn't on the
      // stage. 
      target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
      target.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
      target.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
      
      target.addEventListener(Event.REMOVED, removedListener);
    }

    private function unRegisterForMouseEvents ():void {
      target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
      target.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
      target.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    }

    private function onMouseDown (e:MouseEvent):void {
      lastMousePos.x = e.stageX;
      lastMousePos.y = e.stageY;
      mouseIsDown = true;
    }

    private function onMouseUp (e:MouseEvent):void {
      mouseIsDown = false;
    }

    private function onMouseMove (e:MouseEvent):void {
      if (mouseIsDown) {
        var newMousePos:Point = new Point(e.stageX, e.stageY);
        var deltaX:Number = newMousePos.x - lastMousePos.x;
        var deltaY:Number = newMousePos.y - lastMousePos.y;
        lastMousePos.x = newMousePos.x;
        lastMousePos.y = newMousePos.y;

        if (doClip) {
          // Drag the target around the clipped region
          if (targetOffset.x - deltaX > origTargetW - rightBoundary) {
            targetOffset.x = origTargetW - rightBoundary;
          } else if (targetOffset.x - deltaX < 0) {
            targetOffset.x = 0;
          } else {
            targetOffset.x -= deltaX;
          }
          if (targetOffset.y - deltaY > origTargetH - bottomBoundary) {
            targetOffset.y = origTargetH - bottomBoundary;
          } else if (targetOffset.y - deltaY < 0) {
            targetOffset.y = 0;
          } else {
            targetOffset.y -= deltaY;
          }

          target.scrollRect = new Rectangle(targetOffset.x, 
                                            targetOffset.y,
                                            rightBoundary,
                                            bottomBoundary);
        } else {
          // Drag the target normally, using bounds if stipulated.
          if (useBounds) {
            if (target.x + deltaX < leftBoundary) {
              target.x = leftBoundary;
            } else if (target.x + deltaX > rightBoundary) {
              target.x = rightBoundary;
            } else {
                target.x += deltaX;
            }
            if (target.y + deltaY < topBoundary) {
              target.y = topBoundary;
            } else if (target.y + deltaY > bottomBoundary) {
              target.y = bottomBoundary;
            } else {
              target.y += deltaY;
            }
          } else {
            target.x += deltaX;
            target.y += deltaY;
          }
        }
        e.updateAfterEvent();
      }
    }
    
    private function removedListener (e:Event):void {
      // Unregister for mouse events before object is removed from stage.
      deactivate();
    }
  }
}