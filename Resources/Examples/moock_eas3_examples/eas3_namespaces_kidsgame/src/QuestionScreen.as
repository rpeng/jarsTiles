package {
  import flash.events.*;
  import flash.display.*;
  import flash.text.*;
  import flash.net.*;
  
  // Creates the user interface for a question
  public class QuestionScreen extends Sprite {
    private var status:TextField;
    private var game:KidsGame;
    private var items:Array;
    private var thisQuestionItem:Item;
    
    // Constructor
    public function QuestionScreen (game:KidsGame, 
                                    items:Array, 
                                    thisQuestionItem:Item) {
      // Store a reference to the main game engine
      this.game = game;
      
      // Store question data
      this.items = items;
      this.thisQuestionItem = thisQuestionItem;
    
      // Put the question on screen
      makeQuestion();
    }

    // Creates and displays a question's interface
    public function makeQuestion ():void {
      // Display the graphic for the item
      var imgLoader:Loader = new Loader();
      addChild(imgLoader);
      imgLoader.load(new URLRequest(thisQuestionItem.src));
		  
      // Add a selection of clickable words for the player to choose
      // from. For the sake of simplicity, we'll display the name of every
      // item in the item set.
      var wordButton:WordButton;
      for (var i:int = 0; i < items.length; i++) {
        wordButton = new WordButton();
        wordButton.setButtonText(items[i].name);
  	    wordButton.setID(items[i].id);
        wordButton.y = 110 + i*(wordButton.height + 5);
        wordButton.addEventListener(MouseEvent.CLICK, clickListener);
        addChild(wordButton);
      }
		  
		  // Create a text field in which to display question status
      status = new TextField();
      status.autoSize = TextFieldAutoSize.LEFT;
      status.y = wordButton.y + wordButton.height + 10;
      status.selectable = false;
      addChild(status);
    }

    // Displays a message in the status field
    public function displayResult (msg:String):void {
      status.text = msg;
    }
    
    // Displays user input for this question  
    public function disable ():void {
      // Disables mouse events for all children of this Sprite.
      mouseChildren = false;
    }
    
    // Responds to the clicking of a word button
    private function clickListener (e:MouseEvent):void {
      // The player's guess is the item id associated with 
      // the WordButton object, as set in makeQuestion().
      game.submitGuess(e.target.getID());
    }
  }
}