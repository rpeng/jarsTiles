package zoo {
  import flash.display.Sprite;
  
  public class VirtualZoo extends Sprite {
    public function VirtualZoo () {
      var pet = new VirtualPet("Stan");
      pet.eat(new Apple());
      pet.eat(new Sushi());
    }
  }
}
