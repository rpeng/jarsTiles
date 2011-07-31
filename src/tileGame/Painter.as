package tileGame{
	import flash.display.MovieClip;

	/*
	This class is responsible for rendering everything on the screen
	
	What the class does is, it will link a Tile instance with a movieclip that pertains
	to a single tile. It also will link TileGrids with a movieclip.
	
	Requires:
	Tile movieclips
	Grid movieclips
	
	Properties:
	
	gridClip 	// the movieclip that represents one grid (abstract)
	tileClip	// the movieclip that represents one tile object
	playerClip 	// the movieclip that represents one player object
	
	Methods:
	
	renderGrid(_pArray:Array, _tArray:Array)		// (re)renders the whole grid on the screen, basically updates everything
													// takes in two arrays
													
	updatePlayer(_player:Player)					// updates player to its current x,y cordinate
	movePlayer(_player:Player,dx:Number,dy:Number)	// moves player by dx and dy + move animation
	updateTile(_tile:Tile)							// updates the tile clip
	
	
	*/
	public class Painter {
		
		public function renderGrid(grid:TileGrid)
		{
			// will implement later
		}
		
		public function Painter(_tile:Class,_player:Class) {
			tileClip = _tile;
			playerClip = _player;
		}
	
	}
}
