package {
  import flash.display.*;
  import flash.net.*;
  import flash.events.*;
  import flash.system.*;
  
  public class Main extends Sprite {
    public static const START:String = "START";
    
    private var loader:Loader;
  	
    public function Main() {
      loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.INIT, 
                                                initListener);
      loader.load(new URLRequest("Module.swf"));

      stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveListener);
    }

    private function mouseLeaveListener (e:Event):void {
      // Share a built-in event
      loader.contentLoaderInfo.sharedEvents.dispatchEvent(e);      
    }

    private function initListener (e:Event):void {
      // Share a custom event
      LoaderInfo(e.target).sharedEvents.dispatchEvent(
                                                     new Event(Main.START));
    }
  }
}