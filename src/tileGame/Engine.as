package tileGame {
	// The engine defines methods to enable gameplay
	
	// Requires:
	
	public class  Engine {
		
		internal var gameGrid:TileGrid;
		internal var players:Array;
		
		public function init(){
			// initializes resources
			gameGrid = new TileGrid(100,100,5,5);
			
		}
		
		public function Engine() {
			// constructor code
		}

	}
	
}
