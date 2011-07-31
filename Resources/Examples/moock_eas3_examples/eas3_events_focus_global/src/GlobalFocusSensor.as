package {
  import flash.display.*;
  import flash.events.*;
  import flash.text.*;

  // Demonstrates how to handle focus events from a global 
  // point of reference. Colors text fields green when focused.
  public class GlobalFocusSensor extends Sprite {
    public function GlobalFocusSensor () {
      // Create text fields
      var field1:TextField = new TextField();
      field1.width      = 100;
      field1.height     = 30;
      field1.border     = true;
      field1.background = true;
      field1.type = TextFieldType.INPUT;

      var field2:TextField = new TextField();
      field2.width      = 100;
      field2.height     = 30;
      field2.y          = 50;
      field2.border     = true;
      field2.background = true;
      field2.type = TextFieldType.INPUT;

      // Add text fields to the display list
      addChild(field1);
      addChild(field2);
      
      // Register for FocusEvent.FOCUS_IN events
      stage.addEventListener(FocusEvent.FOCUS_IN, focusInListener);
    }

    // Handle all FocusEvent.FOCUS_IN events in this application
    private function focusInListener (e:FocusEvent):void {
      // Set the background color of the focused TextField object to green
      TextField(e.target).backgroundColor = 0xFF00FF00;

      // Set the background color of the TextField object that lost focus 
      // to white
      if (e.relatedObject is TextField) {
        TextField(e.relatedObject).backgroundColor = 0xFFFFFFFF;
      }
    }
  }
}
