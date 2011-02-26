package tileGame{
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
	
	Methods:
	
	gridResize(_gWidth:Number, _gHeight:Number)			- Resizes tile grid to this size
	getTileXY(p:Point)									- Gets a tile object given an x,y coordinate point
	getTileRowCol(p:Point)								- Gets a tile object given a row and column cordinate
	
	
	
	*/
	public class TileGrid {
		
		var gridWidth:Number;
		var gridHeight:Number;
		var numTileRows:Number;
		var numTileCols:Number;
		
		public function gridResize(_gWidth:Number, _gHeight:Number) {
			gridWidth = _gWidth;
			gridHeight = _gHeight;
		}
		
		public function TileGrid(_gWidth:Number,
								 _gHeight:Number,
								 _numRow:Number,
								 _numCol:Number) {

			numTileRows = _numRow;
			numTileCols = _numCol;
		}

	}
	
}
