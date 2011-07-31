package zoo {
  // The Food class is the superclass of the various types of food that 
  // pets eat.
  public class Food {
    // Tracks the number of calories this piece of food has
    private var calories:int;
    //  This piece of food's human readable name
    private var name:String;
    
    // Constructor
    public function Food (initialCalories:int) {
      // Record the specified initial number of calories
      setCalories(initialCalories);
    }
    
    // Returns the number of calories this piece of food has
    public function getCalories ():int {
      return calories;
    }
    
    // Assigns the number of calories this piece of food has
    public function setCalories (newCalories:int):void {
      calories = newCalories;
    }
    
    // Returns this piece of food's human readable name
    public function getName ():String {
      return name;
    }
    
    // Assigns this piece of food's human readable name
    public function setName (newName:String):void {
      name = newName;
    }  
  }
}