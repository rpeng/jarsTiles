package zoo {
  // The VirtualPetInsufficientDataException class represents an exception
  // thrown when an excessively short pet name is specified for a pet
  public class VirtualPetInsufficientDataException 
                                          extends VirtualPetNameException  {
    // Constructor
    public function VirtualPetInsufficientDataException () {
      // Invoke the VirtualPetNameException constructor
      super("Pet name too short.");
    }
  }
}