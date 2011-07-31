package {
  public class QueryManager {

    japanese function search (word:String, 
                              options:JapaneseSearchOptions):Array {
      trace("Now searching for '" + word + "'.\n"
            + " Match type: " + options.getMatchType() + "\n"
            + " English language variant: "  + options.getEnglishVariant());
 
      // Code here (not shown) would search the Japanese-to-English 
      // dictionary and return the results, but we'll just return a 
      // hard-coded list of results as a proof-of-concept:
      return ["English Word 1", "English Word 2", "etc"];
    }
    
    english function search (word:String, 
                             options:EnglishSearchOptions):Array {
      trace("Now searching for '" + word + "'.\n"
            + " Match type: " + options.getMatchType() + "\n"
            + " Use kanji in results: "  + options.getKanjiInResults());

      // Code here (not shown) would search the English-to-Japanese 
      // dictionary and return the results, but we'll just return a 
      // hard-coded list of results as a proof-of-concept:
      return ["Japanese Word 1", "Japanese Word 2", "etc"];
    }
  }
}