package {
  public class JapaneseSearchOptions extends SearchOptions {
    public static const ENGLISH_UK:String = "EnglishUK";
    public static const ENGLISH_US:String = "EnglishUS";

    private var englishVariant:String;
    
    public function JapaneseSearchOptions () {
      setEnglishVariant(JapaneseSearchOptions.ENGLISH_UK);
    }
    
    public function getEnglishVariant ():String {
      return englishVariant;
    }
    
    public function setEnglishVariant (newEnglishVariant:String):void {
      englishVariant = newEnglishVariant;
    }
  }
}