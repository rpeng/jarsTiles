package {
  import flash.display.Sprite;
  import flash.events.*;  

  public class Module extends Sprite {
    public static const START:String = "START";
    
    public function Module() {
      loaderInfo.sharedEvents.addEventListener(Module.START, startListener);
      loaderInfo.sharedEvents.addEventListener(Event.MOUSE_LEAVE,
                                               mouseLeaveListener);
    }

    public function startListener (e:Event):void {
      trace("Module.startListener() was invoked...");
    }

    private function mouseLeaveListener (e:Event):void {
      trace("Module.mouseLeaveListener() was invoked...");
    }
  }
}

