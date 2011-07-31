package {
  import flash.display.*;
  import flash.events.*;
  import flash.utils.*;
	
  // The main application class for a child's learn-to-read game 
  // demonstrating the basic usage of namespaces in ActionScript.
  // The player is shown a picture of a color or a fruit, and asked to 
  // choose its name from a list of options.
  public class KidsGame extends Sprite {
    private var gameItems:Items;  // The list of all items in the game
    private var thisQuestionItem:Item; // The item for each question
    private var questionScreen:QuestionScreen;  // The user interface

    // Constructor
    public function KidsGame() {
      // Retrieve the game items (the fruits and colors which the user must 
      // name)
      gameItems = new Items();
      // Display the first question
      newQuestion();
    }

    // Creates and displays a new random game question
    public function newQuestion ():void {
      // Get the full list of item types (an array of namespaces)
      var itemTypes:Array = gameItems.getItemTypes();
      // Pick a random item type (one of the namespaces in itemTypes)
      var randomItemType:Namespace = itemTypes[Math.floor(
                                     Math.random()*itemTypes.length)];

    	  
      // Retrieve the randomly chosen item set
      var items:Array = gameItems.randomItemType::getItems();
    
      // Randomly pick the item for this question from the item set
      thisQuestionItem = items[Math.floor(Math.random()*items.length)];
    
      // Remove the previous question, if there was one
      if (questionScreen != null) {
        removeChild(questionScreen);
      }
      
      // Display the new question
      questionScreen = new QuestionScreen(this, items, thisQuestionItem);
      addChild(questionScreen);
    }
		
    // Handles a player's guess
    public function submitGuess (guess:int):void {
      trace("Guess: " + guess + ", Correct: " + thisQuestionItem.id);
      if (guess == thisQuestionItem.id) {
        questionScreen.displayResult("Correct!");
        // Disable the answer buttons while the 
        // player waits for the next question.
        questionScreen.disable();
        // Wait 3 seconds then show another question.
        var timer:Timer = new Timer(3000, 1);
        timer.addEventListener(TimerEvent.TIMER, doneResultDelay);
        timer.start();
      } else {
        questionScreen.displayResult("Incorrect. Please try again.");
      }
    }
    
    // Makes a new question after the previous question is finished.
    private function doneResultDelay (e:TimerEvent):void {
      newQuestion();
    }
  }
}
