package zoo {
  public class Apple extends Food {
    private static var DEFAULT_CALORIES = 100;
  
    public function Apple (initialCalories = 0) {
      if (initialCalories <= 0) {
        initialCalories = Apple.DEFAULT_CALORIES;
      }
      super(initialCalories);

      setName("Apple");
    }
  }
}
