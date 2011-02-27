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
					
	tilePos 			- Point of tile, based on above enumeration method
	
	tileDeathTime		- The time that tile.die() was first called
	tileDeathDuration	- How long (in ms) before tile will drop
	
	Methods:
	
	die(_dTime:Number)	- Tile dies after _gtime milliseconds
	
	
	*/
	import flash.geom.Point;

	public class Tile {
		/*
		Status states
		*/
		public const STATE_ALIVE = 1;
		public const STATE_DYING = 2;
		public const STATE_DEAD = 0;
		
		// properties
		var tileStatus:uint;
		var tilePos:Point; 
		
		var tileDeathTime:Date;
		var tileDeathDuration:Number;
		
		public function Tile(_pos:Point) {
			tileStatus = STATE_ALIVE;
			tilePos = _pos;
		}
		
		public function setStatus(_status:uint){
			if ((_status >= 0) && (_status <= 2))
				tileStatus = _status;
			else
				trace("Invalid status :"+String(_status)+"set!");
		}
		
		public function getStatus(){
			// getStatus also updates the status
			if (tileStatus == STATE_DYING){
				// if tile is dying, check for death
				var currentTime:Date = new Date();
				if (currentTime.time() - tileDeathTime.time() >= tileDeathDuration)
					this.setStatus(STATE_DEAD);
					// tile is dead. may play some kind of dying animation here?
			}
			return this.tileStatus;
		}
		
		public function die(_dTime:Number)
		{	// this will kill the tile after _gTime ms, if tile is alive
			if (this.getStatus() == STATE_ALIVE){
				tileDeathTime = new Date();
				tileDeathDuration = _dTime;
				this.setStatus(STATE_DYING);
			}
		}
		
	}
	
}
