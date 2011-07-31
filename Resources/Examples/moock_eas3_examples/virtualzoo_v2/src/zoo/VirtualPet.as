package zoo {
  import flash.utils.setInterval;
  import flash.utils.clearInterval;
  
  public class VirtualPet {
    private static var maxNameLength:int = 20;
    private static var maxCalories:int = 2000;
    private static var caloriesPerSecond:int = 100;
    
    private var petName:String;
    private var currentCalories:int = VirtualPet.maxCalories/2;
    private var digestIntervalID:int;

    public function VirtualPet (name:String):void {
      setName(name);
      digestIntervalID = setInterval(digest, 1000);
    }

    public function eat (foodItem:Food):void {
      if (currentCalories == 0) {
        trace(getName() + " is dead. You can't feed it.");
        return;
      }

      if (foodItem is Apple) {
        if (Apple(foodItem).hasWorm()) {
          trace("The " + foodItem.getName() + " had a worm. " + getName() 
                + " didn't eat it.");
          return;
        }
      }
    
      var newCurrentCalories:int = currentCalories + foodItem.getCalories();
      if (newCurrentCalories > VirtualPet.maxCalories) {
        currentCalories = VirtualPet.maxCalories;
      } else {
        currentCalories = newCurrentCalories;
      }
      trace(getName() + " ate some " + foodItem.getName() + "." 
            + " It now has " + currentCalories  + " calories remaining.");
    }

    public function getHunger ():Number {
      return currentCalories / VirtualPet.maxCalories;
    }

    public function setName (newName:String):void {
      if (newName.indexOf(" ") == 0) {
        throw new VirtualPetNameException();
      } else if (newName == "") {
        throw new VirtualPetInsufficientDataException();
      } else if (newName.length > VirtualPet.maxNameLength) {
        throw new VirtualPetExcessDataException();
      }
    
      petName = newName;
    }

    public function getName ():String {
      return petName;
    }
    
    private function digest ():void {
      // If digesting more calories would leave the pet's currentCalories at 
      // 0 or less...
      if (currentCalories - VirtualPet.caloriesPerSecond <= 0) {
        // ...stop the interval from calling digest()
        clearInterval(digestIntervalID);
        // Then give the pet an empty stomach
        currentCalories = 0;
        // And report the pet's death
        trace(getName() + " has died.");
      } else {
        // ...otherwise, digest the stipulated number of calories
        currentCalories -= VirtualPet.caloriesPerSecond;
        
        // And report the pet's new status
        trace(getName() + " digested some food. It now has " 
              + currentCalories + " calories remaining.");
      } 
    }
  }
}

