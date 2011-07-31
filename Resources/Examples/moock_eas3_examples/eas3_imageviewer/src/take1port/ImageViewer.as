package take1port {
  import flash.display.Sprite;
  import flash.display.Loader;
  import flash.net.URLRequest;

  public class ImageViewer {
    private var imgLoader:Loader;

    public function ImageViewer (target:Sprite, depth:int) {
      imgLoader = new Loader();
      target.addChildAt(imgLoader, depth);
		}

    public function loadImage (URL:String):void {
      imgLoader.load(new URLRequest(URL));
    }
  }
}