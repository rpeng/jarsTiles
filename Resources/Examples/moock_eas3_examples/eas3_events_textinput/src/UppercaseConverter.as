package {
  import flash.display.*;
  import flash.events.*;
  import flash.text.*;  

  // Automatically converts all lowercase text input to uppercase
  public class UppercaseConverter extends Sprite {
    private var inputfield:TextField;
    
    public function UppercaseConverter () {
      // Create a TextField object
      inputfield = new TextField();
      inputfield.text = "";
      inputfield.width  = 150;
      inputfield.height = 30;
      inputfield.border     = true;
      inputfield.background = true;
      inputfield.type = TextFieldType.INPUT;
      addChild(inputfield);

      // Register with inputfield for TextEvent.TEXT_INPUT events
      inputfield.addEventListener(TextEvent.TEXT_INPUT, textInputListener);
    }

    // Triggered whenever the user attempts to add new text to inputfield
    private function textInputListener (e:TextEvent):void {
      // Prevent the user-supplied text from being added to the text field
      e.preventDefault();
      // Add the equivalent uppercase character to the text field
      inputfield.replaceText(inputfield.caretIndex, 
                             inputfield.caretIndex, 
                             e.text.toUpperCase());
      // Set the insertion point (caret) to the end of the new text, so
      // the user thinks they entered the text
      var newCaretIndex:int = inputfield.caretIndex +  e.text.length;
      inputfield.setSelection(newCaretIndex, newCaretIndex);
    }
  }
}
