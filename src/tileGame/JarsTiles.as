package tileGame{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class JarsTiles extends MovieClip {
		// Testing script
		public function JarsTiles() {
			trace("jarsTiles v0.1");
			trace("Creating grid of size 100 x 100 px, with 5 rows and 5 cols of tiles");
			var grid = new TileGrid(100,100,5,5);
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
			// can add more test cases...
			var p:Array = new Array(new Point(0,19),
									new Point(21,21),
									new Point(81,45));
			
			for (var i = 0; i < p.length; i++)
				trace ("Point: "+p[i]+" => maps to tile: "+grid.getTileXY(p[i]).tilePos);
		}
	}
	
}
