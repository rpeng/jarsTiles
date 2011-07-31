package {
  import flash.display.*;
 
  public class Caller extends Sprite {
    
    private var shelteredObject:ShelteredClass;
    
    public function Caller () {
      shelteredObject = new ShelteredClass();
      callSecretMethod();
      displaySecret();
    }
    
    public function callSecretMethod ():void {
      var key:Namespace = shelteredObject.getRestrictedNamespace(this);
      if (key != null) {
        shelteredObject.key::secretMethod();
      }
    }
    
    public function displaySecret ():void {
      var key:Namespace = shelteredObject.getRestrictedNamespace(this);
      if (key != null) {
        trace(shelteredObject.key::secretData);
      }
    }
  }
}
