package {
  import flash.display.Sprite;
  import zoo.*;
  
  public class VirtualZoo extends Sprite {
    private var pet;

    public function VirtualZoo () {
      pet = new VirtualPet("Stan");
      pet.eat(new Apple());
      pet.eat(new Sushi());
    }
  }
}

