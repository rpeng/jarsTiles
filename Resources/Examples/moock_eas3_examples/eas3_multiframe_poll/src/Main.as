package {
  import flash.display.*;
  import flash.events.*;
  import flash.net.*;
  import flash.utils.*;

  public class Main extends Sprite {
    private var loader:Loader;
  	
    public function Main() {
      // Load Module.swf
      loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.INIT, 
                                                initListener);
      loader.load(new URLRequest("Module.swf"));
    }

    private function initListener (e:Event):void {
      // The loaded .swf file has been initialized, so start polling for
      // the existence of the TextField.
      var timer:Timer = new Timer(100, 0);
      timer.addEventListener(TimerEvent.TIMER, timerListener);
      timer.start(); 
    }

    private function timerListener (e:TimerEvent):void {
      // Check whether the loaded .swf file's TextField has been created
      if (loader.content.hasOwnProperty("t")) {
        // The TextField exists now, so we can safely access it
        trace(Object(loader.content).t.text);
        
        // Stop the timer
        e.target.stop();
      }
    }
  }
}
