
package {
  import flash.display.*;
  import flash.text.*;
  import flash.events.*;

  public class LoginManager {
    private var username:TextField;
    private var password:TextField;

    public function LoginManager (username:TextField, 
                                  password:TextField,
                                  submitBtn:SimpleButton) {
      this.username = username;
      this.password = password;
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