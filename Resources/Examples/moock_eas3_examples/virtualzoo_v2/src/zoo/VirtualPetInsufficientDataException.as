package zoo {
  public class VirtualPetInsufficientDataException 
                                          extends VirtualPetNameException  {
    public function VirtualPetInsufficientDataException () {
      super("Pet name too short.");
    }
  }
}