package {
  import flash.display.Sprite;

  public class EllipseDemo extends Sprite {
    public function EllipseDemo () {
      var e:Ellipse = new Ellipse(20, 50);
      e.setHeight(55);
      e.setWidth(230);
      addChild(e);
    }
  }
}
