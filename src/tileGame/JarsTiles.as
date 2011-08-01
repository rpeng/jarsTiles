package tileGame{
	import tileGame.Engine;
	import flash.display.MovieClip;

	public class JarsTiles extends MovieClip {
		// main program entry point
		public function JarsTiles() {
			trace("jarsTiles v0.1");
			var app:Engine = new Engine(this);
		}
	}
	
}
