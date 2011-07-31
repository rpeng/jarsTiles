package {
  import flash.display.*;
  import flash.text.*;
  import flash.events.*;

  // Demonstrates the use of the TextEvent.LINK event in a simplified
  // chat room example with clickable user names. 
  public class ChatRoom extends Sprite {
    // A text field containing chat messages
    private var messages:TextField;
    
    public function ChatRoom () {
      // Create a text field with 'event:' protocol links
      messages = new TextField();
      messages.multiline = true;
      messages.autoSize = TextFieldAutoSize.LEFT;
      messages.border     = true;
      messages.background = true;
      messages.htmlText = 
        "<a href='event:privateChat,user1'>Andy</a> says: What's up?<br>"
      + "<a href='event:privateChat,user2'>Mike</a> says: I'm busy...<br>"
      + "<a href='event:privateChat,user1'>Andy</a> says: Ok see you later";
      addChild(messages);

      // Register with the 'messages' TextField object for 
      // TextEvent.LINK events
      messages.addEventListener(TextEvent.LINK, linkListener);
    }

    // Executed any time the user clicks an 'event:' protocol link in
    // the 'messages' TextField object
    private function linkListener (e:TextEvent):void {
      // The content of e.text is the full string that follows "event:" in
      // the href attribute. For example, "privateChat,user1". Here we
      // split that text into an operation ("privateChat") the 
      // corresponding argument ("user1").
      var requestedCommand:Array = e.text.split(",");
      var operationName:String   = requestedCommand[0];
      var argument:String        = requestedCommand[1];

      // If the operation requested is a private chat request, invoke
      // the requestPrivateChat() method.
      if (operationName == "privateChat") {
        requestPrivateChat(argument);
      }
    }

    // Sends a private chat invitation to the specified user
    private function requestPrivateChat (userID:String):void {
      trace("Now requesting private chat with " + userID);
    }
  }
}
