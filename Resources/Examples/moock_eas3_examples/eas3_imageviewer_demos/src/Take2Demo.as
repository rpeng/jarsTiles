package {
  import flash.display.Sprite;
  import take2.ImageViewer;
  
  public class Take2Demo extends Sprite {
    private var iv:ImageViewer;

    public function Take2Demo () {
      iv = new ImageViewer(100, 100, 200, 250, 3, 0xFF0000);
      iv.loadImage("picture.jpg");
      addChild(iv);
    }
  }
}