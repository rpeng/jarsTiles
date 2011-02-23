package tileGame {
	/*
	The Tile class represents one tile on the tile grid.
	Tiles are numbered in a linear fasion, for example on a
	3 x 3 grid:
	 _________
	| 1| 2 | 3|
	|--|---|--|
	| 4| 5 | 6|
	|--|---|--|
	| 7| 8 | 9|
	|---------|
	
	Properties:
	
	playerName	- name of player
	playerID	- unique number identification
	gridPos		- player's position on the TileGrid
	
	*/
	public class Tile {
		
		var isAlive:Boolean;
		var tileNo:uint;
		
		public function Tile() {
			// constructor code
		}

	}
	
}
