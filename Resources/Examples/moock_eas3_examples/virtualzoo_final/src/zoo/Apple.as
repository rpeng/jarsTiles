package zoo {
  // The Apple class represents one of the types of food a pet can eat
  public class Apple extends Food {
    // The amount of calories in an Apple object, if no specific 
    // amount is indicated
    private static var DEFAULT_CALORIES:int = 100;
    // Tracks whether an Apple object has a worm
    private var wormInApple:Boolean;
  
    // Constructor
    public function Apple (initialCalories:int = 0) {
      // If no valid calorie amount is specified...
      if (initialCalories <= 0) {
        // ...give this Apple object the default amount
        initialCalories = Apple.DEFAULT_CALORIES;
      }
      // Invoke the Food class constructor
      super(initialCalories);

      // Randomly determine whether this Apple object as a worm (50% chance)
      wormInApple = Math.random() >= .5;
      
      // Give this food item a name
      setName("Apple");
    }

    // Returns a Boolean indicating whether the Apple object has a worm
    public function hasWorm ():Boolean {
      return wormInApple;
    }
  }
}
