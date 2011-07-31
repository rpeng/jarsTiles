package {
  import flash.display.Sprite;

  public class JEDictionary extends Sprite {
    private var queryMan:QueryManager;

    japanese var options:JapaneseSearchOptions;
    english  var options:EnglishSearchOptions;
  
    private var lang:Namespace;
	  
    public function JEDictionary() {
      queryMan = new QueryManager();
		  
      japanese::options = new JapaneseSearchOptions();
      japanese::options.setMatchType(SearchOptions.MATCH_STARTSWITH);
      japanese::options.setEnglishVariant(JapaneseSearchOptions.ENGLISH_US);

      english::options = new EnglishSearchOptions();
      english::options.setMatchType(SearchOptions.MATCH_CONTAINS);
      english::options.setKanjiInResults(true);
      
      // Do a Japanese search...
      setModeJapaneseToEnglish();
      findWord("sakana");

      // Do an English search...
      setModeEnglishToJapanese();
      findWord("fish");
    }
		
    public function findWord (word:String):void {
      var words:Array = queryMan.lang::search(word, lang::options);
      trace(" Words found: " + words);
		}
		
    public function setModeEnglishToJapanese ():void {
      lang = english;
    }

    public function setModeJapaneseToEnglish ():void {
      lang = japanese;
    }
  }
}
