package {
  import flash.display.Sprite;

  public class ShoppingBasketDemo extends Sprite {
    public function ShoppingBasketDemo () {
      var basket:ShoppingBasket = new ShoppingBasket();
      basket.addProduct(new Product("Nintendo Wii"));
      basket.addProduct(new Product("Xbox 360"));
      basket.addProduct(new Product("PlayStation 3"));
      addChild(basket);
    }
  }
}
