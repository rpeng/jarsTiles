package {
  import flash.display.*;
  import flash.text.*;

  public class FontFallbackDemo extends Sprite {
    public function FontFallbackDemo () {
      var format:TextFormat = new TextFormat();
      // Assigns the first font available
      format.font = getFont(["ZapfChancery", "Verdana", "Arial", "_sans"]);

      var t:TextField = new TextField();
      t.text = "ActionScript is fun!";
      t.autoSize = TextFieldAutoSize.LEFT;
      t.setTextFormat(format)
      
      addChild(t);
    }

    // Given a list of fonts, returns the name of the first font in the list
    // that is available either as an embedded font or a device font
    public function getFont (fontList: Array):String {
      var availableFonts:Array = Font.enumerateFonts(true);
      for (var i:int = 0; i < fontList.length; i++) {
        for (var j:int = 0; j < availableFonts.length; j++) {
          if (fontList[i] == Font(availableFonts[j]).fontName) {
            return fontList[i];
          }
        }
      }
      return null;
    }
  }
}