package {
  import flash.display.Sprite;
  import flash.events.*;  

  public class ToolPanel extends Sprite {
    private var enabled:Boolean;
    
    public function ToolPanel () {
      enabled = false;
      
      var tool1:Tool = new Tool();
      var tool2:Tool = new Tool();
      var tool3:Tool = new Tool();
      
      tool2.x = tool1.width + 10;
      tool3.x = tool2.x + tool2.width + 10;
      
      addChild(tool1);
      addChild(tool2);
      addChild(tool3);

      // Register with this object for MouseEvent.CLICK event notification
      // during the capture phase
      addEventListener(MouseEvent.CLICK, clickListener, true);
    }

    private function clickListener (e:MouseEvent):void {
      // If this ToolPanel object is disabled...
      if (!enabled) {
        // ...then stop this click event from reaching this ToolPanel 
        // object's descendants
        e.stopPropagation();
        trace("Panel disabled. Click event dispatch halted.");
      }
    }
  }
}
