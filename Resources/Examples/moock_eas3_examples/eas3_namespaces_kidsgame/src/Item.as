package {
  // A simple data container that stores information about an item.
  public class Item {
    // The item's name (for example, "apple")
    public var name:String;
    // The URL from which to load an image representing the item
    public var src:String; 
    // A unique identifier for the item, used to evaluate player guesses
    public var id:int;     
    
    // Constructor
    public function Item (name:String, src:String, id:int) {
      this.name = name;
      this.src = src;
      this.id = id;
    }
  }
}