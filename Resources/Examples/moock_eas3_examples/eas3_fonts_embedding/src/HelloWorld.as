package {
  import flash.display.*;
  import flash.text.*;

  // This class demonstrates how to format text using embedded fonts.
  // The fonts, themselves, are embedded in the class FontEmbedder.
  public class HelloWorld extends Sprite {
    // Make a reference to the class that embeds the fonts for this 
    // application. This reference causes the class and, by extension, its 
    // fonts to be compiled into the .swf file.
    FontEmbedder;

    public function HelloWorld () {
      // Create a text field
      var t:TextField = new TextField();
      
      // Tell ActionScript to render this text field using embedded fonts
      t.embedFonts = true;  
      
      // Use two variations of Verdana (normal, and bold)
      t.htmlText = "<FONT FACE='Verdana'>Hello <b>world</b></FONT>";

      // Enable FlashType (i.e., Saffron) text rendering
      t.antiAliasType = AntiAliasType.ADVANCED;

      // Add the text field to the display list
      addChild(t);
    }
  }
}