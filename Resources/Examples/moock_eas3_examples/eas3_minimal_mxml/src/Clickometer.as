package {
  import mx.controls.*;
  import mx.core.*;
  import flash.events.*;
  import flash.utils.*;

  public class Clickometer {
    private static var lastClickTime:int = 0;
    private static var numClicks:int = 0;
    private static var grid:DataGrid;
    private static var button:Button;
  
    // Program entry point
    public static function main ():void {
      // Create a button
      button = new Button();
      button.label = "Click Quickly!";
      button.addEventListener(MouseEvent.CLICK, clickListener);
      
      // Create a data grid
      grid = new DataGrid();
      grid.dataProvider = new Array();

      // Add visual assets to the screen. Application.application is a 
      // reference to the top-level Flex application, a general container 
      // for controls and visual assets. 
      var mxmlApp:Application = Application(Application.application);
      mxmlApp.addChild(button);
      mxmlApp.addChild(grid);
    }
  
    private static function clickListener (e:MouseEvent):void {
      var now:int = getTimer();
      var elapsed:int = now - lastClickTime;
      lastClickTime = now;
      numClicks++;
      grid.dataProvider.addItem({Clicks: numClicks, "Time (ms)": elapsed});
    }
  }
}