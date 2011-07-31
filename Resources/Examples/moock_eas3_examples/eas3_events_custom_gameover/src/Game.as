package {
  import flash.events.*;
  import flash.utils.*;  // Required for the Timer class

  public class Game extends EventDispatcher {
    public static const GAME_OVER:String = "gameOver";

    public function Game () {
      // Force the game to end after one second
      var timer:Timer = new Timer(1000, 1);
      timer.addEventListener(TimerEvent.TIMER, timerListener);
      timer.start();
      
      function timerListener (e:TimerEvent):void {
        endGame();
      }
    }

    private function endGame ():void {
      // Perform game-ending duties (code not shown)...
      
      // 	...then ask ActionScript to dispatch an event indicating that 
      // the game is over
      dispatchEvent(new Event(Game.GAME_OVER));
    }
  }
}
