package tileGame{
	import flash.geom.Point;

	/*
	The TileGrid will represent a grid of tiles.
	It is the container that has the attributes of all the tiles.
	For example: a 3x3 TileGrid
	
	In counting XY cordinates, we assume point (0,0) starts at the top left.
	
	<-------width--------->		
	 ______________________		^
	| (0,0)| (0,1) | (0,2)|		h
	|------|-------|------|		e
	| (1,0)| (1,1) | (1,2)|		i
	|------|-------|------|		g
	| (2,0)| (2,1) | (2,2)|		h
	|---------------------|		t
								v
	
	Properties:
	
	numTileRows			- number of rows (horizontal)
	numTileCols			- number of columns (vertical)
	
	gridWidth			- pixel width of grid
	gridHeight			- pixel height of grid
	
	tileWidth			- width of tiles on grid
	tileHeight			- height of tiles on grid
	
	tileArray			- array containing all the tiles on this grid
	
	Methods:
	
	getGridWidth // these do exactly as you expect from them
	getGridHeight
	getTileWidth
	getTileHeight
	getNumRows
	getNumCols
	
	gridResize(_gWidth:Number, _gHeight:Number)			- Resizes tile grid to this size
	getTileXY(p:Point)									- Gets a tile object given an x,y coordinate point
	getTileRowCol(p:Point)								- Gets a tile object given a row and column cordinate
	
	
	
	*/
	public class TileGrid {
		
		var gridWidth:Number;
		var gridHeight:Number;
		
		var numTileRows:Number;
		var numTileCols:Number;
		
		var tileWidth:Number;
		var tileHeight:Number;
		
		var tileArray:Array;
		
		// Accessors
		public function getGridWidth():Number{
			return gridWidth;
		}
		
		public function getGridHeight():Number{
			return gridHeight;
		}
		
		public function getTileWidth():Number{
			return tileWidth;
		}
		
		public function getTileHeight():Number{
			return tileHeight;
		}
		
		public function getNumRows():Number{
			return numTileRows;
		}
		
		public function getNumCols():Number{
			return numTileCols;
		}
		
		public function gridResize(_gWidth:Number, _gHeight:Number){
			gridWidth = _gWidth;
			gridHeight = _gHeight;
			tileWidth = gridWidth/numTileCols;
			tileHeight = gridHeight/numTileRows;
		}
		
		public function TileGrid(_gWidth:Number,
								 _gHeight:Number,
								 _numRow:Number,
								 _numCol:Number) {

			numTileRows = _numRow;
			numTileCols = _numCol;
			gridResize(_gWidth,_gHeight);
			for(i = 0; i < numTileRows; i++){
				var rowArray:Array; // every row contains an array
				for(j = 0; j < numTileCols; j++){ // need to populate array with empty tiles
					rowArray.push(new Tile(new Point(i,j)));
				}
				tileArray.push(rowArray);
			}
		}
	}
	
}
