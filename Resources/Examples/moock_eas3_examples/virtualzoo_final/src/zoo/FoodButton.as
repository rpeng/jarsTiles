package zoo {
  import flash.display.*
  import flash.events.*;
  import flash.text.*;

  // The FoodButton class represents a simple clickable-text button
  public class FoodButton extends Sprite {
    // The text to be clicked
    private var text:TextField;
    // The formatting of the text when it is *not* under the mouse pointer
    private var upFormat:TextFormat;
    // The formatting of the text when it *is* under the mouse pointer
    private var overFormat:TextFormat;

    // Constructor
    public function FoodButton (label:String) {
      // Enable the "hand" mouse cursor for interactions with this object
      // (The buttonMode variable is inherited from Sprite.)
      buttonMode = true;
      // Disable mouse events for this object's children
      // (The mouseChildren variable is inherited
      // from DisplayObjectContainer.)
      mouseChildren = false;
      
      // Define the text formatting used when this object is *not* 
      // under the mouse pointer
      upFormat = new TextFormat("_sans",12,0x006666,true);
      // Define the text formatting used when this object *is* 
      // under the mouse pointer
      overFormat = new TextFormat("_sans",12,0x009999,true);
      
      // Create the clickable text field, and add it to this object's
      // display hierarchy
      text = new TextField();
      text.defaultTextFormat = upFormat;
      text.text = label;
      text.autoSize = TextFieldAutoSize.CENTER;
      text.selectable = false;
      addChild(text);

      // Register to be notified when the mouse moves over this object
      addEventListener(MouseEvent.MOUSE_OVER, mouseOverListener);
      // Register to be notified when the mouse moves off of this object
      addEventListener(MouseEvent.MOUSE_OUT, mouseOutListener);
    }

    // Disables mouse event notifications for this object
    public function disable ():void {
      // (The mouseEnabled variable is inherited from InteractiveObject.)
      mouseEnabled = false;
    }

    // Triggered when the mouse moves over this object
    public function mouseOverListener (e:MouseEvent):void {
      // Apply the "mouse over" text format
      text.setTextFormat(overFormat);
    }

    // Triggered when the mouse moves off of this object
    public function mouseOutListener (e:MouseEvent):void {
      // Apply the "mouse not over" text format
      text.setTextFormat(upFormat);
    }
  }
}