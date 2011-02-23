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
	
	tileStatus		- Status of the tile
					(1) if tile is alive
					(2) if tile is dying
					(0) if tile is dead
					
	tileNo		- Point of tile, based on above enumeration method
	
	Methods:
	
	die(_gtime:Time)	- Tile dies after _gtime
	
	
	*/
	public class Tile {
		/*
		Status states
		*/
		public const STATE_ALIVE = 1;
		public const STATE_DYING = 2;
		public const STATE_DEAD = 0;
		
		// properties
		var tileStatus:Boolean;
		var tileNo:Point;
		var isDying:Boolean;
		
		public function Tile() {
			// constructor code
		}

	}
	
}
