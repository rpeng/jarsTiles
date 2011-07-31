package zoo {
  // The VirtualPetNameException class represents an exception thrown when
  // a generally invalid pet name is specified for a pet
  public class VirtualPetNameException extends Error {
    // Constructor
    public function VirtualPetNameException (
                           message:String = "Invalid pet name specified.") {
      //  Invoke the Error constructor
      super(message);
    }
  }
}