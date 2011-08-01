package tileGame {
	/*
	The Tile class represents one tile on the tile grid.
	Tiles are numbered in a matrix fasion, for example on a
	3 x 3 grid:
	 ______________________
	| (0,0)| (0,1) | (0,2)|
	|------|-------|------|
	| (1,0)| (1,1) | (1,2)|
	|------|-------|------|
	| (2,0)| (2,1) | (2,2)|
	|---------------------|
	
	Properties:
	
	tileStatus		- Status of the tile
					(1) if tile is alive
					(2) if tile is dying
					(0) if tile is dead
					
	tilePos 			- Point of tile, based on above enumeration method
	
	tileDeathTime		- The time that tile.die() was first called
	tileDeathDuration	- How long (in ms) before tile will drop
	
	Methods:
	
	die(_dTime:Number)	- Tile dies after _gtime milliseconds
	
	
	*/
	import flash.geom.Point;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.Event;

 // need to abstract this abit more

	public class Tile{
		/*
		Status states
		*/
		public static const STATE_ALIVE = 1;
		public static const STATE_DYING = 2;
		public static const STATE_DEAD = 0; 
		
		// properties
		var tileClip:MovieClip;
		var tileStatus:int;
		var tilePos:Point; 
		
		var tileDeathTime:Number;
		var tileDeathDuration:Number;
		
		var deathTimer:Timer;
		var deathText:TextField;
		
		public function Tile(_pos:Point) {
			tileStatus = STATE_ALIVE;
			tilePos = _pos;
			tileClip = new greenTile();
		}
		
		public function resize(t_width:int,t_height:int) {
			tileClip.width = t_width;
			tileClip.height = t_height;
		}
		
		public function setXY (_x:int,_y:int) {
			tileClip.x = _x;
			tileClip.y = _y;
		}
		
		public function setStatus(_status:uint){
			if ((_status >= 0) && (_status <= 2))
				tileStatus = _status;
			else
				trace("Invalid status :"+String(_status)+"set!");
		}
		
		public function Selected(){
			tileClip.gotoAndStop("Selected");
		}
		
		public function getStatus(){
			return this.tileStatus;
		}
		
		public function deathFrameHandler(e:Event){ // updates text on frame
			if (this.deathText != null) { // simply draws the time till death
				this.deathText.text = String((tileDeathDuration-(new Date().time - this.tileDeathTime))/1000)
			}
		}
		
		public function deathHandler(e:TimerEvent){
			this.setStatus(STATE_DEAD);
			//trace(tilePos+" dead")
			this.tileClip.gotoAndPlay("Dead");
			
			this.tileClip.removeEventListener(Event.ENTER_FRAME,this.deathFrameHandler);
			this.tileClip.removeChild(deathText);
			deathText = null;
			
			deathTimer.removeEventListener(TimerEvent.TIMER,this.deathHandler);
			deathTimer.stop(); // no more need for this
		}
		
		public function die(_dTime:Number)
		{	// this will kill the tile after _gTime ms, if tile is alive
			if (this.getStatus() == STATE_ALIVE){
				//trace(tilePos+" dying")

				tileDeathTime = new Date().time;
				tileDeathDuration = _dTime;
				
				// set state and clip
				this.setStatus(STATE_DYING);
				this.tileClip.gotoAndPlay("Dying");
		
				// set up timer
				
				this.deathTimer = new Timer(_dTime);
				var secondTimer:Timer = new Timer(1000);
				
				deathTimer.start();
				deathTimer.addEventListener(TimerEvent.TIMER,this.deathHandler);
				
				// show death text
				deathText = new TextField();
				deathText.selectable = false;
				deathText.defaultTextFormat = new TextFormat(null,40);				
				deathText.text = String(deathTimer.currentCount);
				this.tileClip.addEventListener(Event.ENTER_FRAME,this.deathFrameHandler);
				this.tileClip.addChild(deathText);
			}
		}
		
	}
	
}
