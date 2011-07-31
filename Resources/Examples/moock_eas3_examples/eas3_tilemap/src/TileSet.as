package {
  import flash.geom.Rectangle;
  import flash.net.URLRequest;
  import flash.utils.*;
  import flash.display.*;
  import flash.events.*;

  // Stores a set of tiles that can be used to render a tile map.
  // Tiles can be loaded and extracted from a single external bitmap.
  // Each tile is stored as an array of bytes, ready to be composited
  // into a rendered graphic by a tile map renderer.
  public class TileSet extends EventDispatcher {
    // An event constant
    public static const TILES_LOADED:String = "TILES_LOADED";
    
    // An array of ByteArrays, each representing a tile
    private var tiles:Array;
    // The size specified for a set of loaded tiles
    private var loadedTileSize:int;
    
    // Constructor
    public function TileSet () {
      tiles = new Array();
    }

    // Returns the tile with the given ID. IDs are always integers
    public function getTile (id:int):ByteArray {
      return tiles[id];
    }

    // Assigns a new tile to the given ID. IDs are always integers
    public function setTile (id:int, tileData:ByteArray):void {
      tiles[id] = tileData;
    }

    // Assigns an entire new set of tiles
    public function setTiles (newTiles:Array):void {
      tiles = newTiles.slice(0);
    }

    // Adds a new tile to the tile set, and automatically assigns
    // it the next highest available ID.
    public function addTile (tileData:ByteArray):void {
      tiles.push(tileData);
    }

    // Returns the number of tiles in the tile set
    public function getNumTiles ():int {
      return tiles.length;
    }
    
    // Returns the size of the tiles in the current tile set. The size
    // is the height/width of a square tile. It is deduced based on the 
    // number of bytes in the first tile (each pixel requires 4 bytes).
    public function getTileSize ():int {
      return Math.sqrt(ByteArray(tiles[0]).length/4);
    }

    // Loads a new graphic from which a tile set will be extracted.
    // When the tiles are ready, the TileSet.TILES_LOADED event fires.
    public function loadTiles (imgURL:String, tileSize:Number):void {
      loadedTileSize = tileSize;
      var l:Loader = new Loader();
      l.contentLoaderInfo.addEventListener(Event.INIT, tileInitListener);
      l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,
                                    tileIoErrorListener);
      l.load(new URLRequest(imgURL));
    }

    // Splits a graphic into an Array of ByteArrays representing tiles,
    // which is then returned. Each tile is square with a width and 
    // height specified by 'size'.
    public function convertBitmapToTiles (size:int, 
                                          data:BitmapData):Array {
      var newTileSet:Array = new Array();
      var numTilesH:int = data.width/size;
      var numTilesV:int = data.height/size;
      
      for (var i:int = 0; i < numTilesV; i++) {
        for (var j:int = 0; j < numTilesH; j++) {
          newTileSet.push(data.getPixels(new Rectangle(j*size, i*size,
                                                       size, size)));
        }
      }
      return newTileSet;
    }

    // Responds to the loading of a tile-set graphic. Replaces the current 
    // tile set with a new tile set extracted from the loaded graphic.
    private function tileInitListener (e:Event):void {
      setTiles(convertBitmapToTiles(loadedTileSize, 
                                    e.target.content.bitmapData));
      dispatchEvent(new Event(TileSet.TILES_LOADED));
    }
    
    // Responds to the failed loading of a tile-set graphic.
    private function tileIoErrorListener (e:IOErrorEvent):void {
      trace("load error");
    }
  }
}