package {
  import flash.display.*;
  import flash.events.*;
  import flash.text.*;

  // A very simple checkbox widget
  public class CheckBox extends Sprite {
    private var label:TextField;    // The checkbox's text label
    private var icon:CheckBoxIcon;  // The checkbox's graphical icon
    private var checked:Boolean;    // Flag indicating whether the
                                    // checkbox is currently checked
    // Constructor
    public function CheckBox (msg:String) {
      // When created, the checkbox is not checked
      checked = false;
      
      // Create the graphical icon
      icon = new CheckBoxIcon();
      
      // Create the text label
      label = new TextField();
      label.text = msg;
      label.autoSize = TextFieldAutoSize.LEFT;
      label.selectable = false;
      
      // Position the text label next to the graphical icon
      label.x = icon.x + icon.width + 5;

      // Add the label and icon to this object as display children
      addChild(icon);
      addChild(label);      

      // Start listening for mouse click events dispatched to this object
      // or any of its children (i.e., the label or the icon)
      this.addEventListener(MouseEvent.CLICK, clickListener);
    }    

    // Handles to mouse click events
    private function clickListener (e:MouseEvent):void {
      if (checked) {
        icon.uncheck();
        checked = false;
      } else {
        icon.check();
        checked = true;
      }
    }
  }
}