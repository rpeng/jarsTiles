package {
  import flash.display.*;

  // Demonstrates the use of the CustomMousePointer class.
  public class CustomMousePointerDemo extends Sprite {
    private var pointer:CustomMousePointer;

    // Constructor
    public function CustomMousePointerDemo () {
      // Create a new CustomMousePointer object and add it to the display 
      // list. The act of adding the CustomMousePointer object to the 
      // display list automatically replaces the system mouse pointer with
      // the CustomMousePointer. 
      pointer = new CustomMousePointer();
      addChild(pointer);
    }
  }
}
