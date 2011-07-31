package {
  import flash.display.*;
  import flash.text.*;
  import flash.events.*;
  
  public class WordHighlighter extends Sprite {
    // The first word
    private var word1:Sprite;
    private var text1:TextField;

    // The second word
    private var word2:Sprite;
    private var text2:TextField;
    
    // The highlight shape
    private var bgRect:Shape;
    
    public function WordHighlighter () {
      // Create the first TextField and Sprite
      word1  = new Sprite();
      text1 = new TextField();
      text1.text = "Products";
      text1.selectable = false;
      text1.autoSize = TextFieldAutoSize.LEFT;
      word1.addChild(text1)
      text1.addEventListener(MouseEvent.MOUSE_OVER, mouseOverListener);
      text1.addEventListener(MouseEvent.MOUSE_OUT, mouseOutListener);

      // Create the second TextField and Sprite
      word2  = new Sprite();
      text2 = new TextField();
      text2.text = "Services";
      text2.selectable = false;
      text2.autoSize = TextFieldAutoSize.LEFT;
      word2.x = 75;
      word2.addChild(text2)
      text2.addEventListener(MouseEvent.MOUSE_OVER, mouseOverListener);
      text2.addEventListener(MouseEvent.MOUSE_OUT, mouseOutListener);
  
      // Add the Sprite instances to WordHighlighter's display hierarchy
      addChild(word1);
      addChild(word2);
  
      // Create the Shape (a rounded rectangle)
      bgRect = new Shape();
      bgRect.graphics.lineStyle(1);
      bgRect.graphics.beginFill(0xCCCCCC, 1);
      bgRect.graphics.drawRoundRect(0, 0, 60, 15, 8);
    }
  
    // Invoked when the mouse pointer moves over a text field.
    private function mouseOverListener (e:MouseEvent):void {
      // If the TextField's parent Sprite does not already contain
      // the shape, then move it there. DisplayObjectContainer.contains()
      // returns true if the specified object is a descendant
      // of the container.
      if (!e.target.parent.contains(bgRect)) {
        e.target.parent.addChildAt(bgRect, 0);
      }
    }

    // Invoked when the mouse pointer moves off of a text field.
    private function mouseOutListener (e:MouseEvent):void {
      // If the highlight is present...
      if (e.target.parent.contains(bgRect)) {
        // ...remove it
        e.target.parent.removeChild(bgRect);
      }
    }
  }
}
