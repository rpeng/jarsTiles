package {
  import flash.display.Sprite;
  import take4.ImageViewer;
  
  public class Take4Demo extends Sprite {
    private var iv:ImageViewer;

    public function Take4Demo () {
      iv = new ImageViewer(100, 100, 200, 75, 20, 0xFF0000);
      iv.loadImage("picture.jpg");
      addChild(iv);
    }
  }
}