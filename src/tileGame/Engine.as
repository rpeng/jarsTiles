package tileGame
{

	import flash.display.MovieClip;
	import tileGame.Tile;
	import tileGame.Constants;
	import tileGame.TileGrid;
	import com.senocular.utils.KeyObject;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.Stage;

	// The engine defines methods to enable gameplay
	public class Engine
	{
		internal var gameGrid:TileGrid;
		internal var players:Array;
		internal var mainPlayer:MovieClip;
		
		internal var keys:KeyObject;
		
		public function randomDeathHandler(e:TimerEvent)
		{
			var p_x:int = Math.round(Math.random()*(gameGrid.numTileRows-1));
			var p_y:int = Math.round(Math.random()*(gameGrid.numTileCols-1));

			var deathTime = Math.random()*(Constants.TILE_DEATH_MAXIMUM_TIME-
			   Constants.TILE_DEATH_MINIMUM_TIME)+
			   Constants.TILE_DEATH_MINIMUM_TIME;

			var deathTimer:int = Math.round(deathTime);

			trace("requested "+p_x+","+p_y+" to die in "+deathTimer+" ms");

			var deathTile:Tile = gameGrid.getTileRowCol(new Point(p_x,p_y));
			
			if (deathTile != null)
				deathTile.die(deathTimer);
		}

		
		public function init()
		{
			// initializes resources
			gameGrid = new TileGrid(Constants.GRID_DEFAULT_WIDTH,
				Constants.GRID_DEFAULT_HEIGHT,
				Constants.GRID_DEFAULT_ROWS,
				Constants.GRID_DEFAULT_COLS);
			
			// players
			mainPlayer = new playerPic();
			mainPlayer.width = gameGrid.tileWidth;
			mainPlayer.height = gameGrid.tileHeight;
		}
		
		public function frameEventHandler(e:Event){
			if (keys.isDown(Keyboard.LEFT))
				mainPlayer.x -= 4;
			else if (keys.isDown(Keyboard.RIGHT))
				mainPlayer.x += 4;
 
			if (keys.isDown(Keyboard.UP))
				mainPlayer.y -= 4;
			else if (keys.isDown(Keyboard.DOWN))
				mainPlayer.y += 4;
		}
		
		public function Engine(mainRef:MovieClip)
		{
			this.init(); 
			
			mainRef.addChild(gameGrid.mc);
			gameGrid.addChild(mainPlayer);
			trace("added keyvent hanlder");
			// keyboard
			
			keys = new KeyObject(mainRef.stage);
			mainRef.addEventListener(Event.ENTER_FRAME,this.frameEventHandler);
		}

	}
}