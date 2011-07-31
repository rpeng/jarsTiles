package zoo {
  import flash.display.*;
  import flash.events.*;
  import flash.net.*;
  import flash.text.*;

  // The VirtualPetView class graphically depicts a VirtualPet instance. 
  // Images for the pet are loaded at runtime.
  public class VirtualPetView extends Sprite {
    // The pet being displayed
    private var pet:VirtualPet;

    // Container for pet graphics
    private var graphicsContainer:Sprite;
    
    // Pet graphics and text
    private var petAlive:Loader;      // The pet in its alive state
    private var petDead:Loader;       // The pet in its alive state
    private var foodHungry:Loader;    // An icon for the hungry state
    private var foodStarving:Loader;  // An icon for the starving state
    private var petName:TextField;    // Displays the pet's name
    
    // Pet user interface
    private var appleBtn:FoodButton;  // Button for feeding the pet an apple
    private var sushiBtn:FoodButton;  // Button for feeding the pet sushi

    // Load completion detection
    static private var numGraphicsToLoad:int = 4; // Total number 
                                                  // of graphics
    private var numGraphicsLoaded:int = 0;  // Number of graphics 
                                            // loaded so far

    // Constructor
    public function VirtualPetView (pet:VirtualPet) {
      // Store a reference to the pet being displayed
      this.pet = pet;
      
      // Register to be notified when the pet's name changes
      pet.addEventListener(VirtualPet.NAME_CHANGE, 
                           petNameChangeListener);
      // Register to be notified when the pet's condition changes
      pet.addEventListener(VirtualPet.STATE_CHANGE, 
                           petStateChangeListener);
      
      // Make and load the pet graphics
      createGraphicsContainer();
      createNameTag();
      createUI();
      loadGraphics();
    }

    // Creates a container into which to place pet graphics
    private function createGraphicsContainer ():void {
      graphicsContainer = new Sprite();
      addChild(graphicsContainer);
    }

    // Creates a TextField in which to display the pet's name
    private function createNameTag ():void {
      petName = new TextField();
      petName.defaultTextFormat = new TextFormat("_sans",14,0x006666,true);
      petName.autoSize = TextFieldAutoSize.CENTER;
      petName.selectable = false;
      petName.x = 250;
      petName.y = 20;
      addChild(petName);
    }

    // Creates buttons for the user to feed the pet
    private function createUI ():void {
      // The Feed Apple button
      appleBtn = new FoodButton("Feed Apple");
      appleBtn.y = 170;
      appleBtn.addEventListener(MouseEvent.CLICK, appleBtnClick);
      addChild(appleBtn);

      // The Feed Sushi button
      sushiBtn = new FoodButton("Feed Sushi");
      sushiBtn.y = 190;
      sushiBtn.addEventListener(MouseEvent.CLICK, sushiBtnClick);
      addChild(sushiBtn);      
    }

    // Disables the user interface
    private function disableUI ():void {
      appleBtn.disable();
      sushiBtn.disable();
    }

    // Loads and positions the external graphics for the pet
    private function loadGraphics ():void {
      // Graphic showing the pet in its alive state
      petAlive = new Loader();
      petAlive.load(new URLRequest("pet-alive.gif"));
      petAlive.contentLoaderInfo.addEventListener(Event.COMPLETE,
                                           completeListener);
      petAlive.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,
                                           ioErrorListener);

      // Graphic showing the pet in its dead state
      petDead = new Loader();
      petDead.load(new URLRequest("pet-dead.gif"));
      petDead.contentLoaderInfo.addEventListener(Event.COMPLETE,
                                          completeListener);
      petDead.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,
                                          ioErrorListener);

      // The "needs food" icon
      foodHungry = new Loader();
      foodHungry.load(new URLRequest("food-hungry.gif"));
      foodHungry.contentLoaderInfo.addEventListener(Event.COMPLETE,
                                             completeListener);
      foodHungry.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,
                                             ioErrorListener);
      foodHungry.x = 15;
      foodHungry.y = 100;

      // The "needs food badly" icon
      foodStarving = new Loader();
      foodStarving.load(new URLRequest("food-starving.gif"));
      foodStarving.contentLoaderInfo.addEventListener(Event.COMPLETE,
                                               completeListener);
      foodStarving.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,
                                               ioErrorListener);
      foodStarving.x = 15;
      foodStarving.y = 100;
    }

    // Triggered when the pet changes state
    private function petStateChangeListener (e:Event):void {
      // If the pet is dead...
      if (pet.getPetState() == VirtualPet.PETSTATE_DEAD) {
        // ...disable the feed buttons
        disableUI();
      }
      // Update the graphics to reflect the new state of the pet
      renderCurrentPetState();
    }

    // Queries the pet for its current state and renders that 
    // state to the screen
    private function renderCurrentPetState ():void {
      // Clear all graphics
      for (var i:int = graphicsContainer.numChildren-1; i >= 0; i--) {
        graphicsContainer.removeChildAt(i);
      }
      // Check the pet's current state
      var state:int = pet.getPetState();  
      
      // Display appropriate graphics
      switch (state) {
        case VirtualPet.PETSTATE_FULL:
          graphicsContainer.addChild(petAlive);
          break;

        case VirtualPet.PETSTATE_HUNGRY:
          graphicsContainer.addChild(petAlive);
          graphicsContainer.addChild(foodHungry);
          break;
        
        case VirtualPet.PETSTATE_STARVING:
          graphicsContainer.addChild(petAlive);
          graphicsContainer.addChild(foodStarving);
          break;

        case VirtualPet.PETSTATE_DEAD:
          graphicsContainer.addChild(petDead);
          break;
      }
    }

    // Triggered when the pet's name changes
    private function petNameChangeListener (e:Event):void {
      // Update the pet's name on screen
      renderCurrentPetName();
    }

    // Queries the pet for its current name, and renders that 
    // name to the screen
    private function renderCurrentPetName ():void {
      petName.text = pet.getName();
    }

    // Triggered when the "Feed Apple" button is clicked
    private function appleBtnClick (e:MouseEvent):void {
      // Feed the pet an apple
      pet.eat(new Apple());
    }

    // Triggered when the "Feed Sushi" button is clicked
    private function sushiBtnClick (e:MouseEvent):void {
      // Feed the pet some sushi
      pet.eat(new Sushi());
    }

    // Triggered when a graphic finishes loading
    private function completeListener (e:Event):void {
      // Increase (by one) the count of the total number of graphics loaded
      numGraphicsLoaded++;
      // If all the graphics have loaded...
      if (numGraphicsLoaded == numGraphicsToLoad) {
        // ...display the appropriate graphics, then broadcast
        // an Event.COMPLETE event, indicating that this VirtualPetView
        // object is ready to use
        renderCurrentPetState();
        renderCurrentPetName();
        dispatchEvent(new Event(Event.COMPLETE));
      }
    }
    
    // Triggered if a graphic fails to load properly
    private function ioErrorListener (e:IOErrorEvent):void {
      // Display a debugging message describing the loading problem
      trace("Load error: " + e);
    }
  }
}