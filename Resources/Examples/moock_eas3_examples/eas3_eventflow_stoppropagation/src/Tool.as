package {
  import flash.display.Sprite;
  import flash.text.*;
  import flash.events.*;

  public class Tool extends Sprite {
    private var t:TextField;
    
    public function Tool () {
      t = new TextField();
      t.text = "Tool";
      t.autoSize = TextFieldAutoSize.LEFT;
      t.border     = true;
      t.background = true;
      t.selectable = false;
      addChild(t);

      addEventListener(MouseEvent.CLICK, clickListener);
    }

    private function clickListener (e:MouseEvent):void {
      trace("Tool clicked...");
    }
  }
}