package zoo {
  import flash.utils.*;
  import flash.events.*;
  
  // The VirtualPet class represents a pet in the zoo. It extends
  // EventDispatcher so that it can be targeted by event dispatches.
  public class VirtualPet extends EventDispatcher {
    // ==STATIC CONSTANTS==
    // VirtualPet-related event types (handled by the VirtualPetView object
    // that displays the pet on screen)
    public static const NAME_CHANGE:String  = "NAME_CHANGE";
    public static const STATE_CHANGE:String = "STATE_CHANGE";
    
    // States representing the pet's current physical condition
    public static const PETSTATE_FULL:int     = 0;
    public static const PETSTATE_HUNGRY:int   = 1;
    public static const PETSTATE_STARVING:int = 2;
    public static const PETSTATE_DEAD:int     = 3;    

    // ==STATIC VARIABLES==
    // The maximum length of a pet's name
    private static var maxNameLength:int = 20;
    // The maximum number of calories a pet can have
    private static var maxCalories:int = 2000;
    // The rate at which pets digest food
    private static var caloriesPerSecond:int = 100;
    // The default name for pets
    private static var defaultName:String = "Unnamed Pet";
    
    // ==INSTANCE VARIABLES==
    // The pet's name
    private var petName:String;
    // The number of calories currently in the pet's "stomach".
    private var currentCalories:int;
    // The pet's current physical condition
    private var petState:int;
    // A timer for invoking digest() on a regular basis
    private var digestTimer:Timer;

    // Constructor
    public function VirtualPet (name:String):void {
      // Assign this pet's name
      setName(name);
      // Start this pet out with half the maximum calories (a 
      // half-full "stomach").
      setCalories(VirtualPet.maxCalories/2);
    }

    // Starts the pet's life cycle
    public function start ():void {
      // Invoke digestTimerListener() once per second
      digestTimer = new Timer(1000, 0);
      digestTimer.addEventListener(TimerEvent.TIMER, digestTimerListener);
      digestTimer.start(); 
    }  
  
    // Pauses the pet's life cycle
    public function stop ():void {
      if (digestTimer != null) {
        digestTimer.stop();
      }
    }

    // Assigns the pet's name, and notifies listeners of the change
    public function setName (newName:String):void {
      // Throw an exception if the new name is not valid
      if (newName.indexOf(" ") == 0) {
        throw new VirtualPetNameException();
      } else if (newName == "") {
        throw new VirtualPetInsufficientDataException();
      } else if (newName.length > VirtualPet.maxNameLength) {
        throw new VirtualPetExcessDataException();
      }
    
      // Assign the new name
      petName = newName;
      // Notify listeners that the name changed
      dispatchEvent(new Event(VirtualPet.NAME_CHANGE));
    }

    // Returns the pet's name
    public function getName ():String {
      // If the pet has never been assigned a valid name...
      if (petName == null) {
        // ...return the default name
        return VirtualPet.defaultName;
      } else {
        // ...otherwise, return the pet's name
        return petName;
      }
    }

    // Adds some calories to the pet's stomach, in the form of a Food object
    public function eat (foodItem:Food):void {
      // If the pet is dead, abort
      if (petState == VirtualPet.PETSTATE_DEAD) {
        trace(getName() + " is dead. You can't feed it.");
        return;
      }

      // If the food item is an apple, check it for worms. If it has a worm,
      // don't eat it.
      if (foodItem is Apple) {
        if (Apple(foodItem).hasWorm()) {
          trace("The " + foodItem.getName() + " had a worm. " + getName() 
                + " didn't eat it.");
          return;
        }
      }

      // Display a debugging message indicating what the pet ate
      trace(getName() + " ate the " + foodItem.getName() 
            + " (" + foodItem.getCalories() + " calories).");
      // Add the calories from the food to the pet's "stomach"
      setCalories(getCalories() + foodItem.getCalories());
    }

    // Assigns the pet a new number of calories, and changes the pet's
    // state if necessary
    private function setCalories (newCurrentCalories:int):void {
      // Bring newCurrentCalories into the legal range, if necessary
      if (newCurrentCalories > VirtualPet.maxCalories) {
        currentCalories = VirtualPet.maxCalories;
      } else if (newCurrentCalories < 0) {
        currentCalories = 0;
      } else {
        currentCalories = newCurrentCalories;
      }

      // Calculate the number of calories in the pet's stomach, as a 
      // percentage of the maximum calories allowed
      var caloriePercentage:int = Math.floor(getHunger()*100);

      // Display a debugging message indicating how many calories the pet
      // now has
      trace(getName() + " has " + currentCalories + " calories"
            + " (" + caloriePercentage + "% of its food) remaining.");
      
      // If necessary, set the pet's state based on the change in calories
      if (caloriePercentage == 0) {
        // The pet has no food left. So if the pet is not already dead...
        if (getPetState() != VirtualPet.PETSTATE_DEAD) {
          // ...deactivate it
          die();
        }
      } else if (caloriePercentage < 20) {
        // The pet needs food badly. Set its state to starving.
        if (getPetState() != VirtualPet.PETSTATE_STARVING) {
          setPetState(VirtualPet.PETSTATE_STARVING);
        }
      } else if (caloriePercentage < 50) {
        // The pet needs food. Set its state to hungry.
        if (getPetState() != VirtualPet.PETSTATE_HUNGRY) {
          setPetState(VirtualPet.PETSTATE_HUNGRY);
        }
      } else { 
        // The pet doesn't need food. Set its state to full.
        if (getPetState() != VirtualPet.PETSTATE_FULL) {
          setPetState(VirtualPet.PETSTATE_FULL);
        }
      }
    }

    // Returns the number of calories in the pet's "stomach"
    public function getCalories ():int {
      return currentCalories;
    }

    // Returns a floating-point number describing the amount of food left 
    // in the pet's "stomach," as a percentage
    public function getHunger ():Number {
      return currentCalories / VirtualPet.maxCalories;
    }

    // Deactivates the pet
    private function die ():void {
      // Stop the pet's life cycle
      stop();
      // Put the pet in the "dead" state
      setPetState(VirtualPet.PETSTATE_DEAD);
      // Display a debugging message indicating that the pet died
      trace(getName() + " has died.");    
    }
    
    // Reduces the pet's calories according to the pet's digestion rate.
    // This method is called automatically by digestTimer.
    private function digest ():void {
      trace(getName() + " is digesting...");
      setCalories(getCalories() - VirtualPet.caloriesPerSecond);
    }

    // Assigns an integer representing the pet's current physical condition
    private function setPetState (newState:int):void {
      // If the pet has not changed state, abort
      if (newState == petState) {
        return;
      }
      
      // Assign the new state
      petState = newState;
      // Notify listeners that the pet's state changed
      dispatchEvent(new Event(VirtualPet.STATE_CHANGE));
    }

    // Returns an integer representing the pet's current physical condition
    public function getPetState ():int {
      return petState;
    }

    // An event listener for the Timer object that governs digestion
    private function digestTimerListener (e:TimerEvent):void {
      // Digest some food
      digest();
    }
  }
}

