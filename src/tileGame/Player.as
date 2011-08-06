package tileGame {
	/*
	The Player class intends to model all the properties of a
	normal player (be it human or computer).
	
	This class also handles player movement.
	
	Properties:
	
	playerName	- name of player
	playerID	- unique number identification
	pos		- player's position on the TileGrid
	movieClip	-
	
	*/
	import flash.geom.Point;
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import com.senocular.utils.KeyObject;
	
	import tileGame.Engine;
	
	public class Player {
		
		var playerName:String; // what we will call the player
		var playerID:uint;      // unique identification of player
		
		var movieClip:MovieClip; 
		
		public function get mc():MovieClip{
			return this.movieClip;
		}
		
		public function get pos():Point{
			return new Point(movieClip.x,movieClip.y);
		}
		
		public function resize(_width:Number,_height:Number){
			movieClip.width = _width;
			movieClip.height = _height;
		}
		
		// movement handlers
		public function moveRight(){
			movieClip.x += 4;
		}
		
		public function moveLeft(){
			movieClip.x -= 4;
		}
		
		public function moveDown(){
			movieClip.y += 4;
		}
		
		public function moveUp(){
			movieClip.y -= 4;
		}
		
		public function frameEventHandler(caller:Engine,keys:KeyObject){
			// key handler
			if (keys.isDown(Keyboard.LEFT))
				moveLeft();
			else if (keys.isDown(Keyboard.RIGHT))
				moveRight();
 
			if (keys.isDown(Keyboard.UP))
				moveUp();
			else if (keys.isDown(Keyboard.DOWN))
				moveDown();
				
			// nonvelocity
			
			if (movieClip.x > caller.gameGrid.gridWidth)
				movieClip.x = caller.gameGrid.gridWidth;
			else if (movieClip.x < 0)
				movieClip.x = 0;
				
			if (movieClip.y > caller.gameGrid.gridHeight)
				movieClip.y = caller.gameGrid.gridHeight;
			else if (movieClip.y < 0)
				movieClip.y = 0;
		}
		
		public function Player(_playerName:String,_clip:MovieClip) {
			this.playerName = _playerName;
			// this.playerid = ??
			this.movieClip = _clip;
			trace("Player "+this.playerName+" created!");
		}
	}
	
}
