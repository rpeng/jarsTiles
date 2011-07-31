package {
  import flash.display.MovieClip;
  import flash.net.*;

  public class RunningMan extends MovieClip {
    public function goToSite (url:String) {
      var request:URLRequest = new URLRequest(url);
      navigateToURL(request, "_blank");
    }
  }
}