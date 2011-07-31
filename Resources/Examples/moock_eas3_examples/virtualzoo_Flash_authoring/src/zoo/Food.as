package zoo {
  public class Food {
    private var calories;
    private var name;
    
    public function Food (initialCalories) {
      setCalories(initialCalories);
    }
    
    public function getCalories () {
      return calories;
    }
    
    public function setCalories (newCalories) {
      calories = newCalories;
    }
    
    public function getName () {
      return name;
    }
    
    public function setName (newName) {
      name = newName;
    }  
  }
}