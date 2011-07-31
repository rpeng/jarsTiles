package {
  import flash.display.Sprite;

  public class SerializationDemo extends Sprite {
    public function SerializationDemo () {
      var r:Rectangle = new Rectangle(0xFF0000, 0x0000FF);
      r.setSize(10, 15);
      // Displays: lineColor=255|fillColor=16711680|width=10|height=15
      trace(r.serialize());
      
      var p:Point = new Point(5, 6);
      trace(p.serialize());  // Displays: y=6,x=5
    }
  }
}
