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
		internal var mainPlayer:MovieClip;
		
		internal var keys:KeyObject;
		
		internal var randomDeathTimer:Timer;
		
		public function get grid():TileGrid{ // testing method
			return gameGrid;
		}
		
		public function get player():MovieClip{ // testing method #2
			return mainPlayer;
		}
		
		public function getTileUnderPlayer():Tile{
			var tile:Tile = gameGrid.getTileXY(new Point(mainPlayer.y,mainPlayer.x));
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
			mainPlayer = new playerPic();
			mainPlayer.width = gameGrid.tileWidth;
			mainPlayer.height = gameGrid.tileHeight;
		}
		
		public function keyHandler(){
			if (keys.isDown(Keyboard.LEFT))
				mainPlayer.x -= 4;
			else if (keys.isDown(Keyboard.RIGHT))
				mainPlayer.x += 4;
 
			if (keys.isDown(Keyboard.UP))
				mainPlayer.y -= 4;
			else if (keys.isDown(Keyboard.DOWN))
				mainPlayer.y += 4;
			
			if (mainPlayer.x > gameGrid.gridWidth)
				mainPlayer.x = gameGrid.gridWidth;
			else if (mainPlayer.x < 0)
				mainPlayer.x = 0;
				
			if (mainPlayer.y > gameGrid.gridHeight)
				mainPlayer.y = gameGrid.gridHeight;
			else if (mainPlayer.y < 0)
				mainPlayer.y = 0;
		}
		
		public function gameover(){
			randomDeathTimer.stop();
			mainRef.removeEventListener(Event.ENTER_FRAME,frameEventHandler); // no more listen
			keys = null;
			trace("GAME OVER!");
		}
		
		public function frameEventHandler(e:Event){ // main logic
			this.keyHandler();
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
			gameGrid.addChild(mainPlayer);
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