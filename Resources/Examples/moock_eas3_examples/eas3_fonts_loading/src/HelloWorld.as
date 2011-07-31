package {
  import flash.display.*;  
  import flash.text.*;
  import flash.events.*;
  import flash.net.*;

  // This class demonstrates how to format text using loaded fonts.
  // The fonts, themselves, are embedded in the file Fonts.swf.
  public class HelloWorld extends Sprite {
    public function HelloWorld () {
      // Load the .swf file that contains the embedded fonts
      var loader:Loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.INIT, initListener);
      loader.load(new URLRequest("Fonts.swf"));
    }

    // Executed when Fonts.swf has initialized, and its fonts are available    
    private function initListener (e:Event):void {
      // For debugging, show the available embedded fonts
      showEmbeddedFonts();
      
      // The font has loaded, so now display the formatted text
      outputMsg();
    }

    // Displays text formatted with the embedded fonts
    private function outputMsg ():void {
      // Create the text field
      var t:TextField = new TextField();
      t.embedFonts = true;  // Tell ActionScript to render this 
                            // text field using embedded fonts
      // Use two variations of Verdana (normal, and bold)
      t.htmlText = "<FONT FACE='Verdana'>Hello <b>world</b></FONT>";

      // Enable FlashType (i.e., Saffron) text rendering
      t.antiAliasType = AntiAliasType.ADVANCED;
      
      // Add the text field to the display list
      addChild(t);                   
    }

    // Outputs a list of the currently available embedded fonts
    public function showEmbeddedFonts ():void {
      trace("========Embedded Fonts========");
      
      var fonts:Array = Font.enumerateFonts();
      fonts.sortOn("fontName", Array.CASEINSENSITIVE);
      for (var i:int = 0; i < fonts.length; i++) {
        trace(fonts[i].fontName + ", " + fonts[i].fontStyle);
      } 
    }
  }
}
