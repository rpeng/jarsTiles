package {
  import flash.display.*;
  import flash.geom.*;
  import flash.events.*;

  // Creates and displays a draggable "outer space" graphic made up of
  // individual tiles.
  public class SpaceMap extends flash.display.Sprite {
    private var spaceMap:TileMap;  // A map containing the locations of
                                   // space graphic tiles
    private var tiles:TileSet;     // The individual space tile graphics
    // An on-screen, draggable display of spaceMap
    private var draggableSpaceMap:DraggableMapRegion; 
    
    // Constructor
    public function SpaceMap () {
      // Prevent the application from resizing
      stage.scaleMode = StageScaleMode.NO_SCALE;
      
      // Create a new, empty map in which to store 
      // tile IDs (10 across by 15 down).
      spaceMap = new TileMap(10, 15);

      // Load the space tile graphic, and break it into individual tiles,
      // sized 16-pixels square. For a demo with more obvious tiles, 
      // change "spacetiles.gif" to "tiles.gif".
      tiles =  new TileSet();
      tiles.addEventListener(TileSet.TILES_LOADED, tilesLoadedListener);

      tiles.loadTiles("spacetiles.gif", 16);
    }

    // When the tile graphic loads, start the application
    private function tilesLoadedListener (e:Event):void {
      start();
    }

    // Creates an on-screen, draggable display of spaceMap
    private function start ():void {
      // First, randomly assign a tile ID to each position on the map
      spaceMap.randomize(tiles.getNumTiles());
      // Then create a new map viewer that supports dragging. The viewer
      // will display an 80x80 pixel square section of the map, initially
      // positioned at pixel coordinate (30, 40).
      draggableSpaceMap = new DraggableMapRegion(spaceMap, tiles, 
                                             new Rectangle(30, 40, 80, 80));
      // Display the map viewer on screen
      addChild(draggableSpaceMap);
      
      // For expository purposes, display the entire map with no scrolling.
      // The map grid is 10 by 15, and each tile is 16 pixels square, so 
      // the entire displayed map is 160 by 240.
      var wholeSpaceMap:TileMapViewer = 
        new TileMapViewer(spaceMap, tiles, new Rectangle(0, 0, 160, 240));
      addChild(wholeSpaceMap);
      wholeSpaceMap.x = 100;
    }
  }
}