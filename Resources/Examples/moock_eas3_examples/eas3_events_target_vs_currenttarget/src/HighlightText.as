package {
  import flash.display.*;
  import flash.events.*;
  import flash.text.*;

  // Demonstrates the use of Event.target and Event.currentTarget
  public class HighlightText extends Sprite {
    
    // Constructor
    public function HighlightText () {
      // Create a Sprite object
      var s:Sprite = new Sprite();
      s.x = 100;
      s.y = 100;

      // Create a TextField object
      var t:TextField = new TextField();
      t.text = "Click here";
      t.background = true;
      t.border = true;
      t.autoSize = TextFieldAutoSize.LEFT;

      // Put the TextField in the Sprite
      s.addChild(t);

      // Add the Sprite to this object's display hierarchy
      addChild(s);
      
      // Register to be notified when the user focuses any of the Sprite 
      // object's descendants (in this case, there's only one descendant:
      // the TextField, t)
      s.addEventListener(FocusEvent.FOCUS_IN, focusInListener);
    }

    // Listener executed when one of the Sprite object's descendants 
    // is focused
    public function focusInListener (e:FocusEvent):void {
      // Displays: [object TextField]
      trace("Target of this event dispatch: " + e.target);

      // Displays: [object Sprite]
      trace("Object with which this listener registered: "+e.currentTarget);
    
      // Set the text field's background to red. Notice that, for added type
      // safety, we cast Event.target to TextField-—the actual datatype of 
      // the target object.
      TextField(e.target).backgroundColor = 0xFF0000;
      
      // Obtain a reference to the Sprite object
      var theSprite:Sprite = Sprite(e.currentTarget);
    
      // Draw the ellipse
      theSprite.graphics.beginFill(0x0000FF);
      theSprite.graphics.drawEllipse(-10, -10, 75, 40);
    }
  }
}
