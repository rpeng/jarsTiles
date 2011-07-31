package zoo {
  public class VirtualPetExcessDataException 
                                          extends VirtualPetNameException  {
    public function VirtualPetExcessDataException () {
      super("Pet name too long.");
    }
  }
}