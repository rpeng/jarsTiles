package {
  import flash.display.*;
  import flash.geom.*;
  
  // Displays a rectangular region of a TileMap using a specified TileSet.
  // By default TileMapViewer uses TileMapRenderer as its rendering
  // utility class. This default renderer can be replaced with a more 
  // efficient renderer via TileMapViewer.setRenderer().
  public class TileMapViewer extends Bitmap {
    private var map:TileMap;    // The map to display
    private var tiles:TileSet;  // The tiles used to render the map
    private var renderer:ITileMapRenderer;  // Rendering utility object
    private var viewRect:Rectangle;  // The region to display
    
    // Constructor
    public function TileMapViewer (map:TileMap, 
                                   tiles:TileSet,
                                   rect:Rectangle) {
      // Use a temporary dummy BitmapData object for the super() call.
      // The dummy BitmapData object is replaced by setViewRect()
      // before this constructor function returns.
      // ##[the dummy might not be required in the final. see bug 162774]
      super(new BitmapData(1,1));
      // Set the map, tiles, renderer, and region to display
      setMap(map);
      setTiles(tiles);
      setRenderer(new TileMapRenderer());
      setViewRect(rect);
    }

    // Displays a rectangular region of the tile map
    public function setViewRect (rect:Rectangle):void {
      viewRect = rect;
      bitmapData = renderer.getRenderedRegionByPixels(rect);
    }

    // Returns a rectangle indicating which region of 
    // the tile map is currently displayed
    public function getViewRect ():Rectangle {
      return viewRect.clone();
    }

    // Sets the tile map to be displayed
    public function setMap (newMap:TileMap):void {
      map = newMap;
    }

    // Sets the tiles from which the tile map will be rendered
    public function setTiles (newTiles:TileSet):void {
      tiles = newTiles;
    }

    // Sets the utility class that will render the map
    public function setRenderer (newRenderer:ITileMapRenderer):void {
      renderer = newRenderer;
      renderer.setMap(map);
      renderer.setTiles(tiles);
    }
  }
}