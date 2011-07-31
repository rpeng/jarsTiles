package {
  import flash.display.Sprite;
  import take1rewrite.ImageViewer;
  
  public class Take1RewriteDemo extends Sprite {
    private var iv:ImageViewer;

    public function Take1RewriteDemo () {
      iv = new ImageViewer();
      iv.loadImage("picture.jpg");
      addChild(iv);
    }
  }
}