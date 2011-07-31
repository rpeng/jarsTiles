package {
  public class Serializer implements Serializable {
    private var serializationVars:Array;
    private var serializationObj:Serializable;
    private var recordSeparator:String;
  
    public function Serializer () {
      setSerializationObj(this);
    }
  
    public function setSerializationVars (vars:Array):void {
      serializationVars = vars;
    }
  
    public function setSerializationObj (obj:Serializable):void {
      serializationObj = obj;
    }
    
    public function setRecordSeparator (rs:String):void {
      recordSeparator = rs;
    }
  
    public function serialize ():String {
      var s:String = "";
      for (var i:int = serializationVars.length; --i >= 0; ) {
        s += serializationVars[i] 
          + "=" + String(serializationObj[serializationVars[i]]);
        if (i > 0) {
          s += recordSeparator;
        }
      }
      return s;
    }
  }
}
