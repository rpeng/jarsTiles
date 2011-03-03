package tileGame {
	/*
	The Player class intends to contain all the properties of a
	normal player (be it human or computer).
	
	Properties:
	
	playerName	- name of player
	playerID	- unique number identification
	gridPos		- player's position on the TileGrid
	movieClip	-
	
	*/
	import flash.geom.Point;
	import flash.display.MovieClip;
	
	public class Player {
		
		static var numPlayers:uint = 0;
		
		var playerName:String; // what we will call the player
		var playerID:uint;      // unique identification of player
		
		var gridPos:Point;	   // position on the tilegrid (x,y cordinate)
		var movieClip:MovieClip;
		
		public function Player(_playerName = "default",_clip:MovieClip) {
			this.playerName = _playerName;
			this.playerID = numPlayers; // will change this 
										// when we add networking support
										// so we don't have duplicate IDs
			this.movieClip = _clip;
			numPlayers += 1;
		}
	}
	
}
