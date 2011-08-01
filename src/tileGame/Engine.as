package tileGame {
	import flash.display.MovieClip;
	import tileGame.Tile;
	import tileGame.Constants;
	import tileGame.TileGrid;
		
	// The engine defines methods to enable gameplay
	public class Engine {
		internal var gameGrid:TileGrid;
		internal var players:Array;
		
		public function randomDeathHandler(e:TimerEvent) {
			var p_x:int = Math.round(Math.random()*(grid.numTileRows-1));
			var p_y:int = Math.round(Math.random()*(grid.numTileCols-1));
			var deathTimer:int = Math.round(Math.random()*8000+3000);
			trace("requested "+p_x+","+p_y+" to die");
			
			var deathTile:Tile = gameGrid.getTileRowCol(new Point(p_x,p_y));
			if (deathTile != null)
				deathTile.die(deathTimer);
		}

		public function init(){
			// initializes resources
			gameGrid = new TileGrid(Constants.GRID_DEFAULT_WIDTH,
									Constants.GRID_DEFAULT_HEIGHT,
									Constants.GRID_DEFAULT_ROWS,
									Constants.GRID_DEFAULT_COLS)
		}
		
		public function Engine(mainRef:MovieClip) {
			this.init();
		}

	}
	
}
