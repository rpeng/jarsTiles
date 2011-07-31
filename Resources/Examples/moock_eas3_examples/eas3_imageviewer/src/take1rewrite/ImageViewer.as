package take1rewrite {
  import flash.display.Sprite;
  import flash.display.Loader;
  import flash.net.URLRequest;

  public class ImageViewer extends Sprite {
    private var imgLoader:Loader;

    public function ImageViewer () {
      imgLoader = new Loader();
      addChild(imgLoader);
    }

    public function loadImage (URL:String):void {
      imgLoader.load(new URLRequest(URL));
    }
  }
}