package {
  import flash.display.*;
  import flash.utils.ByteArray;
  import flash.geom.*;
  
  // A utility class for generating a BitmapData object that represents
  // an arbitrary a rectangular region of a tile map based on
  // a given tile set. Note that this implementation is fairly brute force.
  // Each time the map is rendered, the entire display region is generated 
  // anew. Greater performance could be achieved by using buffers and 
  // BitmapData.scroll() to avoid unnecessary redrawing of recurring pixels. 
  // For details on one such possible implementation, see:
  // http://gpwiki.org/index.php/Framing_Buffer_Tile_Scrolling_Algorithm
  public class TileMapRenderer implements ITileMapRenderer {
    private var map:TileMap;    // The map to render
    private var tiles:TileSet;  // The tiles used to render the map
    
    // Constructor
    public function TileMapRenderer (map:TileMap = null, 
                                     tiles:TileSet = null) {
      setMap(map);
      setTiles(tiles);
    }

    // Sets the tile map to be displayed
    public function setMap (newMap:TileMap):void {
      map = newMap;
    }

    // Sets the tiles from which the tile map will be rendered
    public function setTiles (newTiles:TileSet):void {
      tiles = newTiles;
    }

    // Renders an arbitrary section of the map to a BitmapData object,
    // which is then returned. The section to render is specified in pixels.
    public function getRenderedRegionByPixels (rect:Rectangle):BitmapData {
      var tileSize:int = tiles.getTileSize();
      var mapNumCols:int = map.getNumCols();
      var mapNumRows:int = map.getNumRows();

      // If necessary, adjust width and height to ensure that the display 
      // region displays at least one tile.
      if (rect.width < tileSize) {
        rect.width = tileSize;
      } 
      if (rect.height < tileSize) {
        rect.height = tileSize;
      } 
      // If necessary, adjust width and height to ensure that the display 
      // region does not exceed the size of the world map.
      if (rect.width > mapNumCols*tileSize) {
        rect.width = mapNumCols*tileSize;
      } 
      if (rect.height > mapNumRows*tileSize) {
        rect.height = mapNumRows*tileSize;
      } 
      // If necessary, adjust x and y to ensure that the display region
      // is always within the bounds of the world map.
      if (rect.x < 0) {
        rect.x = 0;
      }
      if (rect.y < 0) {
        rect.y = 0;
      }
      if (rect.x+rect.width > mapNumCols*tileSize) {
        rect.x = mapNumCols*tileSize - rect.width;
      }
      if (rect.y+rect.height > mapNumRows*tileSize) {
        rect.y = mapNumRows*tileSize - rect.height;
      }

      // Done cleaning the data; now comes the rendering.
      // In order to return a rectangle of pixels representing a
      // region of the tile map, we must first render the tile map to a 
      // temporary buffer. Then, we copy the pixels we want from that 
      // buffer to a final BitmapData object. In theory, we could just
      // render the entire world map once to a large reusable buffer, 
      // and pick the region to render from that, but a world buffer would
      // be limited to 2880x2880, and could consume unacceptable amounts 
      // of memory. Instead, we buffer only a portion of the map, based 
      // on the size of the requested pixel rectangle.

      // Identify which rows and columns on the map contain the specified 
      // pixel rectangle
      var xOffset:int  = rect.x%tileSize;
      var yOffset:int  = rect.y%tileSize;
      var startCol:int = Math.floor(rect.x/tileSize);
      var startRow:int = Math.floor(rect.y/tileSize);
      var numColsToRender:int  = Math.ceil((rect.width+xOffset)/tileSize);
      var numRowsToRender:int  = Math.ceil((rect.height+yOffset)/tileSize);
      
      // Render the rows and columns containing the specified pixel 
      // rectangle to a temporary buffer. 
      var tempBuffer:BitmapData = getRenderedRegionByCoords(startCol, 
                                startRow, numColsToRender, numRowsToRender);

      // Copy the specified pixel rectangle from the temporary buffer to 
      // the final BitmapData object
      var renderedRegion:BitmapData = new BitmapData(rect.width,
                                                     rect.height);
      renderedRegion.copyPixels(tempBuffer, 
                             new Rectangle(xOffset, yOffset, 
                                           rect.width, rect.height),
                             new Point(0,0));
      // Return the BitmapData object containing the requested 
      // rectangular pixel region
      return renderedRegion;
    }
    
    // Renders an arbitrary section of the map to a BitmapData object,
    // which is then returned. The section to render is specified in map
    // coordinates (i.e., rows and columns).
    public function getRenderedRegionByCoords (startCol:int, 
                                               startRow:int, 
                                               numCols:int, 
                                               numRows:int):BitmapData {
      // Create a BitmapData object to hold the rendered region
      var renderedRegion:BitmapData = new BitmapData(
                                           numCols * tiles.getTileSize(),
                                           numRows * tiles.getTileSize());
      // Determine the bottom-most row and right-most column to render.
      var endCol:int = startCol + numCols;
      var endRow:int = startRow + numRows;
      
      // Render the specified tiles 
      var thisTile:ByteArray;
      var tileSize:int = tiles.getTileSize();
      for (var i:int = startRow; i < endRow; i++) {
        for (var j:int = startCol; j < endCol; j++) {
          // BitmapData.setPixels() converts a tile stored as a ByteArray to
          // a rectangular area within the BitmapData object (in this case,
          // renderedRegion).
          thisTile = tiles.getTile(map.getTile(j, i));
          thisTile.position = 0;
          renderedRegion.setPixels(new Rectangle((j-startCol)*tileSize,
                                                 (i-startRow)*tileSize, 
                                                 tileSize, tileSize), 
                                   thisTile);
        }
      }
      // Return the BitmapData object containing the requested 
      // rectangular region
      return renderedRegion;
    }
  }
}