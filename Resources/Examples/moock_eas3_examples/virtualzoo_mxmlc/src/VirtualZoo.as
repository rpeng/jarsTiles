package {
  import flash.display.Sprite;
  import zoo.*;
  
  public class VirtualZoo extends Sprite {
    public function VirtualZoo () {
      var pet = new VirtualPet("Stan");
      pet.eat(new Apple());
      pet.eat(new Sushi());
    }
  }
}
