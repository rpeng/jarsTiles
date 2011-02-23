package tileGame {
	/*
	The Tile class represents one tile on the tile grid.
	Tiles are numbered in a matrix fasion, for example on a
	3 x 3 grid:
	 ______________________
	| (0,0)| (0,1) | (0,2)|
	|------|-------|------|
	| (1,0)| (1,1) | (1,2)|
	|------|-------|------|
	| (2,0)| (2,1) | (2,2)|
	|---------------------|
	
	Properties:
	
	isAlive		- Is the tile still floating
	tileNo		- Point of tile, based on above enumeration method
	
	*/
	public class Tile {
		
		var isAlive:Boolean;
		var tileNo:Point;
		
		public function Tile() {
			// constructor code
		}

	}
	
}
