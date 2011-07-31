package {
  import flash.text.*;
  import flash.display.*;

  // Represents a clickable word on screen (i.e., an available choice for 
  // a question). The ID indicates the item id of the player's
  // guess (see Item.id).
  public class WordButton extends Sprite {
    private var id:int;  // The ID of the item this button represents
    private var t:TextField;

    // Constructor
    public function WordButton () {
      t = new TextField();
      t.autoSize   = TextFieldAutoSize.LEFT;
      t.border     = true;
      t.background = true;
      t.selectable = false;
      addChild(t);      

      buttonMode    = true;
      mouseChildren = false;
    }

    // Assigns the text to display on the button
    public function setButtonText (text:String):void {
      t.text = text;
    }    

    // Assigns the ID of the item this button represents
    public function setID (newID:int):void {
      id = newID;
    }
    
    // Returns the ID of the item this button represents
    public function getID ():int {
      return id;
    }
  }
}