package {
  import flash.errors.IllegalOperationError;

  // Represents a rectangular grid of tile IDs
  public class TileMap {
    private var map:Array;    // A 2-d array of tile IDs
    private var numCols:int;  // The number of columns in the grid
    private var numRows:int;  // The number of rows in the grid
    
    // Constructor
    public function TileMap (numCols:int, numRows:int) {
      setSize(numCols, numRows);
    }

    // Sets the size of the map and removes all existing tile IDs
    public function setSize (numCols:int, numRows:int):void {
      this.numCols = numCols;
      this.numRows = numRows;

      map = new Array();
      for (var i:int = 0; i < numRows; i++) {
        map[i] = new Array();
      }
    }

    // Assigns a tile ID to a specified position in the map
    public function setTile (col:int, row:int, id:int):void {
      if (col >= numCols || row >= numRows) {
        throw new IllegalOperationError("Specified tile location "
                                        + "exceeds map boundaries");
      }
      map[row][col] = id;
    }

    // Returns the tile ID for a specified position in the map
    public function getTile (col:int, row:int):int {
      return map[row][col];
    }
    
    // Returns the number of columns in the map
    public function getNumCols ():int {
      return numCols;
    }
    
    // Returns the number of rows in the map
    public function getNumRows ():int {
      return numRows;
    }

    // Generates a random tile ID for each position in the map.
    // Random IDs fall in the range 0 to numTiles-1.
    public function randomize (numTiles:int):void {
      for (var i:int = 0; i < getNumRows(); i++) {
        for (var j:int = 0; j < getNumCols(); j++) {
          setTile(j, i, Math.floor(Math.random()*numTiles));
        }
      }
    }
  } 
}
