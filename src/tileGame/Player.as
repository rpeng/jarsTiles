package tileGame {
	/*
	The Player class intends to contain all the properties of a
	normal player (be it human or computer).
	
	Properties:
	
	playerName	- name of player
	playerID	- unique number identification
	gridPos		- player's position on the TileGrid
	
	*/
	import flash.geom.Point;
	
	public class Player {
		
		static var numPlayers:uint = 0;
		
		var playerName:String; // what we will call the player
		var playerID:uint;      // unique identification of player
		
		var gridPos:Point;	   // position on the tilegrid
		
		public function Player(_playerName = "default") {
			this.playerName = _playerName;
			this.playerID = numPlayers; // will change this 
										// when we add networking support
										// so we don't have duplicate IDs
			numPlayers += 1;
		}
	}
	
}
