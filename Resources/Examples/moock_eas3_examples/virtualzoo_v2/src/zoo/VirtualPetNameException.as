package zoo {
  public class VirtualPetNameException extends Error {
    public function VirtualPetNameException (
                           message:String = "Invalid pet name specified.") {
      super(message);
    }
  }
}