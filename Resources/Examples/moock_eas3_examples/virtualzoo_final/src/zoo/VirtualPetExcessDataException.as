package zoo {
  // The VirtualPetExcessDataException class represents an exception
  // thrown when an excessively long pet name is specified for a pet
  public class VirtualPetExcessDataException 
                                          extends VirtualPetNameException  {
    // Constructor
    public function VirtualPetExcessDataException () {
      // Invoke the VirtualPetNameException constructor
      super("Pet name too long.");
    }
  }
}