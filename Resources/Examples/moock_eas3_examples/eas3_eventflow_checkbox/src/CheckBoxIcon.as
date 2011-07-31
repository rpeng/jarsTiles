package {
  import flash.display.*;

  // The graphical icon for a checkbox widget
  public class CheckBoxIcon extends Sprite {
    
    // Constructor
    public function CheckBoxIcon () {
      uncheck();      
    }

    // Draws a checkbox icon in the "checked" state
    public function check ():void {
      graphics.clear();
      graphics.lineStyle(1);
      graphics.beginFill(0xFFFFFF);
      graphics.drawRect(0, 0, 15, 15);
      graphics.endFill();
      graphics.lineTo(15, 15);
      graphics.moveTo(0, 15);
      graphics.lineTo(15, 0);
    }

    // Draws a checkbox icon in the "unchecked" state
    public function uncheck ():void {
      graphics.clear();
      graphics.lineStyle(1);
      graphics.beginFill(0xFFFFFF);
      graphics.drawRect(0, 0, 15, 15);
    }
  }
}