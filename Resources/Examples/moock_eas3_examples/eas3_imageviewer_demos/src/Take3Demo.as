package {
  import flash.display.Sprite;
  import take3.ImageViewer;
  
  public class Take3Demo extends Sprite {
    private var iv:ImageViewer;

    public function Take3Demo () {
      iv = new ImageViewer(100, 100, 200, 250, 3, 0xFF0000);
      iv.loadImage("picture.jpg");
      addChild(iv);
    }
  }
}