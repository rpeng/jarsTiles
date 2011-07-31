package {
  import flash.display.*;
  import flash.text.*;
  import flash.events.*;
  import flash.utils.*;

  public class LoginForm extends MovieClip {
    public var username:TextField;
    public var password:TextField;
    public var submitBtn:SimpleButton;

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