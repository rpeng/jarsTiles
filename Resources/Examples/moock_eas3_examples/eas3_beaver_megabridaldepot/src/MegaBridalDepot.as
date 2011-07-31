package {
  import flash.display.*;
  import flash.net.*;
  import flash.system.*;  
  import flash.events.*;  
  import com.beavercore.effects.TextAnimation;

  public class MegaBridalDepot extends Sprite {
    public function MegaBridalDepot () {
      var libLoader:Loader = new Loader();
      libLoader.contentLoaderInfo.addEventListener(
                                                  Event.INIT, initListener);
      libLoader.load(
            new URLRequest("../../eas3_beavercore/bin/eas3_beavercore.swf"), 
            new LoaderContext(false, ApplicationDomain.currentDomain));
    }

    private function initListener (e:Event):void {
      var textAni:TextAnimation = new TextAnimation();
      textAni.start();
    }
  }
}
