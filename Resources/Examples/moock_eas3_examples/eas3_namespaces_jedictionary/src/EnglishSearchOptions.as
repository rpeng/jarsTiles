package {
  public class EnglishSearchOptions extends SearchOptions {
    private var kanjiInResults:Boolean = false;
    
    public function getKanjiInResults ():Boolean {
      return kanjiInResults;
    }
    
    public function setKanjiInResults (newKanjiInResults:Boolean):void {
      kanjiInResults = newKanjiInResults;
    }
  }
}