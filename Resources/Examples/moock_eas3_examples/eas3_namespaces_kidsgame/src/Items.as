package {
  // A simple data-storage class containing the Item objects for the game.
  public class Items {
    // The fruits
    fruit var orange:Item = new Item("Orange", "fruit-orange.jpg", 1);
    fruit var apple:Item  = new Item("Apple", "fruit-apple.jpg", 2);
    
    // The colors
    color var orange:Item = new Item("Orange", "color-orange.jpg", 3);
    color var purple:Item = new Item("Purple", "color-purple.jpg", 4);

    // Arrays that store complete sets of items (i.e., all the fruits, or
    // all the colors)
    fruit var itemSet:Array = [fruit::orange, fruit::apple];
    color var itemSet:Array = [color::orange, color::purple];

    // An array of namespaces representing the types of the item 
    // sets in the game
    private var itemTypes:Array = [color, fruit];
    
    // Returns all the fruit items in the game
    fruit function getItems ():Array {
      return fruit::itemSet.slice(0);
    }

    // Returns all the color items in the game
    color function getItems ():Array {
      return color::itemSet.slice(0);
    }
    
    // Returns the list of available item types in the game
    public function getItemTypes ():Array {
      return itemTypes.slice(0);
    }
  }
}