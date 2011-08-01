package tileGame{
	// Write test code in this class!
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class JarsTilesTest extends MovieClip {
		// Testing script
		public var grid:TileGrid;
		
		public function randomDeathHandler(e:TimerEvent) {
			var p_x:int = Math.round(Math.random()*(grid.numTileRows-1));
			var p_y:int = Math.round(Math.random()*(grid.numTileCols-1));
			var deathTimer:int = Math.round(Math.random()*8000+3000);
			trace("requested "+p_x+","+p_y+" to die");
			
			var deathTile:Tile = grid.getTileRowCol(new Point(p_x,p_y));
			if (deathTile != null)
				deathTile.die(deathTimer);
		}
		
		public function JarsTilesTest() {
			trace("jarsTiles v0.1");
			
			trace("Creating grid of size 100 x 100 px, with 5 rows and 5 cols of tiles");
			grid = new TileGrid(500,500,15,15);
			
			// make a new grid of 100 x 100 px, with 5 rows and 5 cols of tiles.
			// Expect each tile to have width and height of 20
			
			trace("Grid dimensions: "+grid.getGridWidth()+"x"+grid.getGridHeight());
			trace("Tile dimensions: "+grid.getTileWidth()+"x"+grid.getTileHeight());
			 
			// now we test the XY cordinates
			// given our setup, each tile has a width and height of 20px
			// so a point at the following cordinates should correspond to a certain
			// tile:
			
			// (0,19) => (0,0)
			// (21,21) => (1,1)
			// (81,45) => (4,2) 
			// (35, 29) => (1,1)
			// can add more test cases...
			var p:Array = new Array(new Point(0,19),
									new Point(21,21),
									new Point(81,45),
									new Point(35,29));
			 
			for (var i = 0; i < p.length; i++)
				trace ("Point: "+p[i]+" => maps to tile: "+grid.getTileXY(p[i]).tilePos);
			
			this.addChild(grid.gridClip);
			grid.getTileRowCol(new Point(2,3)).die(5000);
			
			var randomDeathTimer:Timer = new Timer(1000);
			randomDeathTimer.start();
			randomDeathTimer.addEventListener(TimerEvent.TIMER,this.randomDeathHandler);
			grid.gridClip.x = 10;
			grid.gridClip.y = 50;
		}
	}
	
}
