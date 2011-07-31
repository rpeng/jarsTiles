package zoo {
  // The Sushi class represents one of the types of food a pet can eat
  public class Sushi extends Food {
    // The amount of calories in a Sushi object, if no specific 
    // amount is indicated    
    private static var DEFAULT_CALORIES:int = 500;
    
    // Constructor
    public function Sushi (initialCalories:int = 0) {
      // If no valid calorie amount is specified...
      if (initialCalories <= 0) {
        // ...give this Sushi object the default amount
        initialCalories = Sushi.DEFAULT_CALORIES;
      }
      // Invoke the Food class constructor
      super(initialCalories);

      // Give this food item a name
      setName("Sushi");
    }
  }
}