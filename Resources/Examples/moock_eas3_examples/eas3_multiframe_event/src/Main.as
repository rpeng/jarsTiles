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
      // The loaded .swf file has been initialized, so register for
      // the Module.ASSETS_READY event.
      loader.content.addEventListener("ASSETS_READY",
                                      assetsReadyListener);
    }

    private function assetsReadyListener (e:Event):void {
      // The TextField exists now, so we can safely access it
      trace(Object(loader.content).t.text);
    }
  }
}
