/**
 * Virtual Zoo Example Program, Final Version
 * from O'Reilly's Essential ActionScript 3.0
 * by Colin Moock
 */

package {
  import flash.display.Sprite;
  import zoo.*;
  import flash.events.*;

  // The VirtualZoo class is the main application class. It extends Sprite
  // so that it can be instantiated and added to the display list at
  // program-start time.
  public class VirtualZoo extends Sprite {
    // The VirtualPet instance
    private var pet:VirtualPet;
    // The object that will render the pet to the screen
    private var petView:VirtualPetView;
    
    // Constructor
    public function VirtualZoo () {
      // Create a new pet, and attempt to give it a name
      try {
        pet = new VirtualPet("Bartholomew McGillicuddy");
      } catch (e:Error) {
        // If attempting to create a VirtualPet object causes an exception,
        // then the object won't be created. Hence, we report the problem
        // and create a new VirtualPet object here with a known-to-be-valid 
        // name.
        trace("An error occurred: " + e.message);
        pet = new VirtualPet("Stan");
      }

      // Create the object that will render the pet to the screen
      petView = new VirtualPetView(pet);
      // Register this VirtualZoo object to be notified when the 
      // rendering object (the "petView") has finished initializing
      petView.addEventListener(Event.COMPLETE, petViewCompleteListener);
    }

    // An event listener triggered when the VirtualPetView object (petView)
    // has finished initializing
    public function petViewCompleteListener (e:Event):void {
      // Add the view to the display list
      addChild(petView);
      // Begin the pet's life cycle
      pet.start();
      // Feed the pet
      pet.eat(new Sushi());
    }
  }
}
