package {
  import flash.display.*;
  import flash.text.*;
  import flash.events.*;
  import flash.utils.*;

  // Demonstrates the use of the ScrollBar class
  public class ScrollBarDemo extends Sprite {
    public function ScrollBarDemo () {
      // Create a TextField
      var inputfield:TextField = new TextField();
      // Seed the text field with some initial content
      inputfield.text = "1\n2\n3\n4\n5\n6\n7\n8\n9";
      inputfield.height = 50;
      inputfield.width  = 100;
      inputfield.border     = true;
      inputfield.background = true;
      inputfield.type = TextFieldType.INPUT;
      inputfield.multiline = true;
      addChild(inputfield);

      // Create a scrollbar, and associate it with the TextField
      var scrollbar:ScrollBar = new ScrollBar(inputfield);
      addChild(scrollbar);
    }
  }
}