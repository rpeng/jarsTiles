package {
  import flash.display.*;
  import flash.events.*;
  import flash.text.*;  

  // A product icon that can be placed in a ShoppingBasket object using
  // ShoppingBasket.addProduct(). In this simplified version, the icon is
  // simply a text field with no corresponding graphical icon.
  public class Product extends Sprite {
    // An event constant for the custom PRODUCT_SELECTED event
    public static const PRODUCT_SELECTED:String = "PRODUCT_SELECTED";
    // The on-screen label showing the product's name
    private var label:TextField;
    // The product's name
    private var productName:String;
    
    // Constructor
    public function Product (productName:String) {
      // Store the product's name
      this.productName = productName;
      
      // Create the on-screen label
      label = new TextField();
      label.text = productName;
      label.autoSize = TextFieldAutoSize.LEFT;
      label.border     = true;
      label.background = true;
      label.selectable = false;
      addChild(label);

      // Start listening for mouse clicks. By registering for 
      // MouseEvent.CLICK events with this object, we'll receive 
      // notification any time its children (e.g., the label) are clicked.
      addEventListener(MouseEvent.CLICK, clickListener);
    }

    // Returns the product's name
    public function getName ():String {
      return productName;
    }

    // Handles MouseEvent.CLICK events. In this example, simply clicking a 
    // product selects it, and causes the Product.PRODUCT_SELECTED event to
    // be dispatched. In a more complete implementation, other factors
    // might be involved. For example, products might be selectable
    // via the keyboard, and selection might be disabled during a
    // transaction with the server.
    private function clickListener (e:MouseEvent):void {
      // Notify all registered listeners that this product was selected.
      // Thanks to ActionScript's hierarchical event dispatch system,
      // by dispatching a custom event targeted at this object, we trigger 
      // not only this object's Product.PRODUCT_SELECTED listeners, but also
      // Product.PRODUCT_SELECTED listeners registered with the 
      // ShoppingBasket instance.
      dispatchEvent(new Event(Product.PRODUCT_SELECTED, true));
    }
  }
}