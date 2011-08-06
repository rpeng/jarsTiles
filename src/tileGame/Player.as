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
		
		var velocity:Point;
		var friction:Number;
		
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
			this.velocity.x += 2;
		}
		
		public function moveLeft(){
			this.velocity.x -= 2;
		}
		
		public function moveDown(){
			this.velocity.y += 2;
		}
		
		public function moveUp(){
			this.velocity.y -= 2;
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
			
			movieClip.x += velocity.x;
			movieClip.y += velocity.y;
			
			if (movieClip.x > caller.gameGrid.gridWidth){
				movieClip.x = caller.gameGrid.gridWidth;
				velocity.x = -velocity.x;
			}
			else if (movieClip.x < 0){
				movieClip.x = 0;
				velocity.x = -velocity.x;
			}
				
			if (movieClip.y > caller.gameGrid.gridHeight){
				movieClip.y = caller.gameGrid.gridHeight;
				velocity.y = -velocity.y;
			}
			else if (movieClip.y < 0){
				movieClip.y = 0;
				velocity.y = -velocity.y;
			}
			
			velocity.x *= friction;
			velocity.y *= friction;
		}
		
		public function Player(_playerName,_clip:MovieClip) {
			this.playerName = _playerName;
			// this.playerid = ??
			this.movieClip = _clip;
			velocity = new Point(0,0);
			friction = 0.84;
			trace("Player "+this.playerName+" created!");
		}
	}
	
}
