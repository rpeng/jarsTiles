package tileGame{
	import tileGame.Engine;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.geom.Point;
	import flash.events.Event;

	public class JarsTiles extends MovieClip {
		
		var debugText:TextField;
		var debugTextFormat:TextFormat;
		var app:Engine;
		
		public function debugEventHandler(e:Event){
			var tilePos:Tile = app.grid.getTileXY(new Point(app.player.x,app.player.y))
			debugText.text = tilePos.tilePos.toString();
		}
		
		public function JarsTiles() {
			// main program entry point
			trace("jarsTiles v0.1");
			
			debugText = new TextField;
			debugTextFormat = new TextFormat;
			
			debugTextFormat.size = 30;
			
			app = new Engine(this);
					
			this.addChild(debugText);
			this.addEventListener(Event.ENTER_FRAME,debugEventHandler);
		}
	}
	
}
