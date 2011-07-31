
package {
  import flash.display.*;
  import flash.text.*;
  import flash.events.*;

  public class LoginForm extends Sprite {
    public function LoginForm () {
      submitBtn.addEventListener(MouseEvent.CLICK, submitListener);
    }

    private function submitListener (e:MouseEvent):void {
      submit(username.text, password.text);
    }

    public function submit (name:String, pass:String):void {
      trace("Now submitting user: " + name + " with password: " + pass);

      // Now transmit login information to server (code not shown).
      // Typically, the flash.net.URLLoader class is used to send 
      // data to a server.
    }
  }
}