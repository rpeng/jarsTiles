package zoo {
  public class Sushi extends Food {
    private static var DEFAULT_CALORIES:int = 500;
    
    public function Sushi (initialCalories:int = 0) {
      if (initialCalories <= 0) {
        initialCalories = Sushi.DEFAULT_CALORIES;
      }
      super(initialCalories);

      setName("Sushi");
    }
  }
}