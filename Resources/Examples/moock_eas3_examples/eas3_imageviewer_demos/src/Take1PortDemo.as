package {
  import flash.display.Sprite;
  import take1port.ImageViewer;
  
  public class Take1PortDemo extends Sprite {
    private var iv:ImageViewer;

    public function Take1PortDemo () {
      iv = new ImageViewer(this, 0);
      iv.loadImage("picture.jpg");
    }
  }
} 
