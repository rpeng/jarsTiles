package tileGame
{

	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.Stage;
	
	import tileGame.Player;
	import tileGame.Tile;
	import tileGame.Constants;
	import tileGame.TileGrid;
	import com.senocular.utils.KeyObject;
	
	// The engine defines methods to enable gameplay
	public class Engine
	{
		internal var mainRef:MovieClip;
		internal var gameGrid:TileGrid;
		internal var players:Array;
		
		internal var mainPlayer:Player;
		
		internal var keys:KeyObject;
		
		internal var randomDeathTimer:Timer;
		
		public function get grid():TileGrid{ // testing method
			return gameGrid;
		}
		
		public function get player():Player{ // testing method #2
			return mainPlayer;
		}
		
		public function getTileUnderPlayer():Tile{
			var tile:Tile = gameGrid.getTileXY(new Point(mainPlayer.pos.x,mainPlayer.pos.y));
			return tile;
		}
		
		public function randomDeathHandler(e:TimerEvent)
		{
			var p_x:int = Math.round(Math.random()*(gameGrid.numTileRows-1));
			var p_y:int = Math.round(Math.random()*(gameGrid.numTileCols-1));

			var deathTime = Math.random()*(Constants.TILE_DEATH_MAXIMUM_TIME-
			   Constants.TILE_DEATH_MINIMUM_TIME)+
			   Constants.TILE_DEATH_MINIMUM_TIME;

			var deathTimer:int = Math.round(deathTime);

		    //trace("requested "+p_y+","+p_x+" to die in "+deathTimer+" ms");

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
			mainPlayer = new Player("default",new playerPic());
			mainPlayer.resize(gameGrid.tileWidth,gameGrid.tileHeight);
		}
		
		public function gameover(){
			randomDeathTimer.stop();
			mainRef.removeEventListener(Event.ENTER_FRAME,frameEventHandler); // no more listen
			keys = null;
			trace("GAME OVER!");
		}
		
		public function frameEventHandler(e:Event){ // main logic
			mainPlayer.frameEventHandler(this,keys);
			//trace(getTileUnderPlayer().tilePos);
			if (getTileUnderPlayer().getStatus() == Tile.STATE_DEAD){
				// game over
				this.gameover();
			}
		}
		
		public function Engine(_mainRef:MovieClip)
		{
			this.init(); 
			mainRef = _mainRef;
			mainRef.addChild(gameGrid.mc);
			gameGrid.addChild(mainPlayer.mc);
			trace("added keyvent hanlder");
			// keyboard
			
			keys = new KeyObject(mainRef.stage);
			randomDeathTimer = new Timer(Constants.TILE_DEATH_TIMER_OFFSET)
			randomDeathTimer.start();
			
			randomDeathTimer.addEventListener(TimerEvent.TIMER,randomDeathHandler);
			mainRef.addEventListener(Event.ENTER_FRAME,this.frameEventHandler);
		}

	}
}