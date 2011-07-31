package {
  import flash.display.*;
  import flash.text.*;

  // Embed fonts for use by any .swf file that loads this file
  public class Fonts extends Sprite {
    [Embed(source="c:/windows/fonts/verdana.ttf", 
           fontFamily="Verdana")]
    private var verdana:Class;

    [Embed(source="c:/windows/fonts/verdanab.ttf", 
           fontFamily="Verdana",
           fontWeight="bold")]
    private var verdanaBold:Class;

    // Constructor
    public function Fonts () {
      // Register this class's embedded fonts in the global font list
      Font.registerFont(verdana);
      Font.registerFont(verdanaBold);
    }
  }
}