package zoo {
  import flash.utils.setInterval;
  import flash.utils.clearInterval;
  
  internal class VirtualPet {
    private static var maxNameLength = 20;
    private static var maxCalories = 2000;
    private static var caloriesPerSecond = 100;
    
    private var petName;
    private var currentCalories = VirtualPet.maxCalories/2;
    private var digestIntervalID;

    public function VirtualPet (name) {
      setName(name);
      digestIntervalID = setInterval(digest, 1000);
    }

    public function eat (foodItem) {
      if (currentCalories == 0) {
        trace(getName() + " is dead. You can't feed it.");
        return;
      }
    
      var newCurrentCalories = currentCalories + foodItem.getCalories();
      if (newCurrentCalories > VirtualPet.maxCalories) {
        currentCalories = VirtualPet.maxCalories;
      } else {
        currentCalories = newCurrentCalories;
      }
      trace(getName() + " ate some " + foodItem.getName() + "." 
            + " It now has " + currentCalories  + " calories remaining.");
    }

    public function getHunger () {
      return currentCalories / VirtualPet.maxCalories;
    }
    
    public function setName (newName) {
      // If the proposed new name has more than maxNameLength characters...
      if (newName.length > VirtualPet.maxNameLength) {
        // ...truncate it
        newName = newName.substr(0, VirtualPet.maxNameLength);
      } else if (newName == "") {
        // ...otherwise, if the proposed new name is an empty string,
        // then terminate this method without changing petName
        return;
      }
    
      // Assign the new, validated name to petName
      petName = newName;
    }

    public function getName () {
      return petName;
    }
    
    private function digest () {
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

