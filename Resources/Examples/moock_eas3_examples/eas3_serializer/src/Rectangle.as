package {
  // The Rectangle subclass implements Serializable directly
  public class Rectangle extends Shape implements Serializable {
    public var width:Number = 0;
    public var height:Number = 0;
    private var serializer:Serializer;
  
    public function Rectangle (fillColor:uint, lineColor:uint) {
      super(fillColor, lineColor)

      // Here is where the composition takes place
      serializer = new Serializer();
      serializer.setRecordSeparator("|");
      serializer.setSerializationVars(["height", "width", 
                                       "fillColor", "lineColor"]);
      serializer.setSerializationObj(this);
    }
  
    public function setSize (w:Number, h:Number):void {
      width = w;
      height = h;
    }
  
    public function getArea ():Number {
      return width * height;
    }
  
    public function serialize ():String {
      // Here is where the Rectangle class forwards the serialize()
      // invocation to the Serializer instance stored in serializer
      return serializer.serialize();
    }
  }
}
