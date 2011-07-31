package {
  import flash.display.*;
  import flash.text.*;
  import flash.events.*;

  // An online shopping basket that can visually contain Product objects.
  public class ShoppingBasket extends Sprite {
    // The on-screen title bar for the shopping basket panel
    private var title:TextField;
    // An array containing the products in this basket
    private var products:Array;
    // The currently selected product
    private var selectedProduct:Product;
    
    // Constructor
    public function ShoppingBasket () {
      // Create a new empty array to hold Product objects
      products = new Array();
      
      // Create the on-screen title bar
      title = new TextField();
      title.text = "No product selected";
      title.autoSize = TextFieldAutoSize.LEFT;
      title.border     = true;
      title.background = true;
      title.selectable = false;
      addChild(title);
      
      // Start listening for Product.PRODUCT_SELECTED event dispatches
      // targeted at child Product objects.
      addEventListener(Product.PRODUCT_SELECTED, productSelectedListener);
    }

    // Adds a new Product object to the shopping basket
    public function addProduct (product:Product):void {
      // Create a new product and add it to the products array
      products.push(product);
      // Add the new product to this object's display hierarchy
      addChild(products[products.length-1]);
      
      // Now that there's a new product, reposition all products
      updateLayout();
    }

    // A very simple product-layout algorithm that sorts all products
    // into a single horizontal line in the order they were added, from left
    // to right
    public function updateLayout ():void {
      var totalX:Number = 0;
      for (var i:int = 0; i < products.length; i++) {
        products[i].x = totalX;
        totalX += products[i].width + 20;   // 20 is the gutter width
        products[i].y = title.height + 20;  // 20 is the gutter height
      }
    }

    // Responds to Product.PRODUCT_SELECTED event dispatches targeted at
    // child Product objects. When a product is selected, this method 
    // updates the shopping basket's title bar to match the selected 
    // product's name.
    private function productSelectedListener (e:Event):void {
      // Remember the selected product in case we need to reference it 
      // in future
      selectedProduct = Product(e.target);
      
      // Update the shopping basket's title
      title.text = selectedProduct.getName();
    }
  }
}
