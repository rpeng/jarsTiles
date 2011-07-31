package {
  public class SearchOptions {
    public static const MATCH_EXACT:String      = "Exact";
    public static const MATCH_STARTSWITH:String = "StartsWith";
    public static const MATCH_CONTAINS:String   = "Contains";

    private var matchType:String;
    
    public function SearchOptions () {
      // Default to exact matching.
      setMatchType(SearchOptions.MATCH_EXACT);
    }
    
    public function getMatchType ():String {
      return matchType;
    }
    
    public function setMatchType (newMatchType:String):void {
      matchType = newMatchType;
    }
  }
}