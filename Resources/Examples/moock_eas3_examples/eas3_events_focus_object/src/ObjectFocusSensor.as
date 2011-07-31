package {
  import flash.display.*;
  import flash.events.*;
  import flash.text.*;

  // Demonstrates how to handle focus events for a single
  // object. Creates a TextField that, once focused, cannot be unfocused 
  // until at least three characters have been entered.
  public class ObjectFocusSensor extends Sprite {
    private var namefield:TextField;
    private var passfield:TextField;

    public function ObjectFocusSensor () {
      // Create text fields
      namefield = new TextField();
      namefield.width      = 100;
      namefield.height     = 30;
      namefield.border     = true;
      namefield.background = true;
      namefield.type = TextFieldType.INPUT;

      passfield = new TextField();
      passfield.width      = 100;
      passfield.height     = 30;
      passfield.y          = 50;
      passfield.border     = true;
      passfield.background = true;
      passfield.type = TextFieldType.INPUT;

      // Add text fields to the display list
      addChild(namefield);
      addChild(passfield);
      
      // Register for focus change events
      namefield.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,
                                 focusChangeListener);
      namefield.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, 
                                 focusChangeListener);
    }

    // Handle all focus change events targeted at namefield
    private function focusChangeListener (e:FocusEvent):void {
      if (e.target == namefield && namefield.text.length < 3) {
        trace("Name entered is less than three characters long");
        e.preventDefault();
      }
    }
  }
}
