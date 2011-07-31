/**
 * Virtual Zoo Example Program
 * from O'Reilly's Essential ActionScript 3.0
 * by Colin Moock
 */

package {
  import flash.display.Sprite;
  import zoo.*;
  
  public class VirtualZoo extends Sprite {
    private var pet:VirtualPet;
    
    public function VirtualZoo () {
      try {
        pet = new VirtualPet("Bartholomew McGillicuddy");
      } catch (e:Error) {
        trace("An error occurred: " + e.message);
        // If attempting to create a VirtualPet object causes an exception,
        // then the object won't be created. Hence, we create a new 
        // VirtualPet object here with a known-to-be-valid name.
        pet = new VirtualPet("Stan");
      }

      pet.eat(new Sushi());
    }
  }
}
