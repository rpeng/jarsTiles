package {
  // Embeds the fonts for this application
  public class FontEmbedder {
    // Forward slashes are required, but case doesn't matter.
    [Embed(source="c:/windows/fonts/verdana.ttf", 
           fontFamily="Verdana")]
    private var verdana:Class;

    [Embed(source="c:/windows/fonts/verdanab.ttf", 
           fontFamily="Verdana",
           fontWeight="bold")]
    private var verdanaBold:Class;
  }
}