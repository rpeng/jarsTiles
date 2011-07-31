package {
  public class Point extends Serializer {
    public var x:Number;
    public var y:Number;
  
    public function Point (x:Number, y:Number) {
      super();
  
      setRecordSeparator(",");
      setSerializationVars(["x", "y"]);
  
      this.x = x;
      this.y = y;
    }
  }
}