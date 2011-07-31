package {
  import flash.display.*;
  import flash.net.*;
  import flash.events.*;
  import flash.system.*;
  
  public class Main extends Sprite {
    private var loader:Loader;
  	
    public function Main() {
      loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.INIT, 
                                                initListener);
      loader.load(new URLRequest("Module.swf"), 
                  new LoaderContext(false, 
                                    ApplicationDomain.currentDomain));
    }

    private function initListener (e:Event):void {
      trace("init");
      Module(e.target.content).start();
    }
  }
}