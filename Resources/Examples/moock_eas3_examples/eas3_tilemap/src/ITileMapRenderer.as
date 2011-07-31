package {
  import flash.display.BitmapData;
  import flash.geom.Rectangle;

  // Describes the services that must be provided by tile map rendering
  // classes. A tile map rendering class must be able to draw a region of a 
  // tile map based on a given tile set. For an example tile map 
  // rendering class, see TileMapRenderer.
  public interface ITileMapRenderer {
    function setMap (newMap:TileMap):void
    function setTiles (newTiles:TileSet):void
    function getRenderedRegionByPixels (rect:Rectangle):BitmapData;
    function getRenderedRegionByCoords (startCol:int, 
                                        startRow:int, 
                                        numCols:int, 
                                        numRows:int):BitmapData;
  }
}