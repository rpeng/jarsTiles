package {
  import flash.display.*;
  import flash.events.*;

  public class Console extends Sprite {
    
    // Constructor
    public function Console () {
      var game:Game = new Game();
      game.addEventListener(Game.GAME_OVER, gameOverListener);
    }

    private function gameOverListener (e:Event):void {
      trace("The game has ended!");
      // Display "back to console" UI (code not shown)
    }
  }
}