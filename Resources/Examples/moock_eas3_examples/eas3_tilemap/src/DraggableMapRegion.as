package {
  import flash.display.*;
  import flash.events.*;
  import flash.geom.*
  
  // A viewer that displays a rectangular region of a TileMap using 
  // a specified TileSet. Supports mouse-dragging of the displayed map.
  public class DraggableMapRegion extends Sprite {
    private var map:TileMap;    // The map to display
    private var tiles:TileSet;  // The tiles used to render the map
    private var mapViewer:TileMapViewer;  // The displayed region of the map

    private var viewRect:Rectangle;       // The region to display
    private var lastViewRect:Rectangle;   // The last region displayed
    
    private var lastMouseX:Number;  // Previous horizontal mouse position
    private var lastMouseY:Number;  // Previous vertical mouse position
    private var dragging:Boolean;   // Flag indicating whether mouse 
                                    // movements should drag the map
    
    // Constructor
    public function DraggableMapRegion (map:TileMap, 
                                        tiles:TileSet,
                                        rect:Rectangle) {
      // Set the map, tiles, and region to display
      this.map = map;
      this.tiles = tiles;
      viewRect = rect;
      
      // Record the most recently displayed region
      lastViewRect = viewRect.clone();

      // Use a TileMapViewer object to handle map display 
      mapViewer = new TileMapViewer(map, tiles, viewRect);
      addChild(mapViewer);
      
      // Register to be notified when this DraggableMapRegion is added to
      // the stage ##[this needs fixing: ADDED is not ADDED_TO_STAGE]
      addEventListener(Event.ADDED, addedListener);
    }

    // When this DraggableMapRegion is added to the stage, 
    // register for mouse events
    private function addedListener (e:Event):void {
      stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener);
      addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
      stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
    }

    // When the mouse clicks this DraggableMapRegion, start dragging the map
    private function mouseDownListener (e:MouseEvent):void {
      lastMouseX = e.stageX;
      lastMouseY = e.stageY;
      dragging = true;
    }

    // When the mouse is released, stop dragging the map
    private function mouseUpListener (e:MouseEvent):void {
      dragging = false;
    }
    
    // If dragging is activated, move the map in correspondence 
    // with mouse movements
    private function mouseMoveListener (e:MouseEvent):void {
      if (dragging) {
        // Determine the new region to display, based on mouse movement
        var moveX:int = e.stageX - lastMouseX;
        var moveY:int = e.stageY - lastMouseY;
        viewRect.x -= moveX;
        viewRect.y -= moveY;

        // Prevent the map from being dragged out of the displayed region
        var maxCropX:int = map.getNumCols()*tiles.getTileSize()
                         -viewRect.width;
        if (viewRect.x > maxCropX) {  // Don't drag too far right
          viewRect.x = maxCropX;
        } else if (viewRect.x < 0) {  // Don't drag too far left
          viewRect.x = 0;
        }
        var maxCropY:int = map.getNumRows()*tiles.getTileSize()
                         -viewRect.height;
        if (viewRect.y > maxCropY) {  // Don't drag too far up
          viewRect.y = maxCropY;
        } else if (viewRect.y < 0) {  // Don't drag too far down
          viewRect.y = 0;
        }

        // Record the current mouse position so that mouse distance
        // travelled can be calculated next time MouseEvent.MOUSE_MOVE
        // occurs
        lastMouseX = e.stageX;
        lastMouseY = e.stageY;

        // Redraw the map only if the display region has changed
        if (!viewRect.equals(lastViewRect)) {
          mapViewer.setViewRect(viewRect);
          e.updateAfterEvent();
          lastViewRect = viewRect.clone();
        }
      }
    }
  }
}
