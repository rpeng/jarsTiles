package {
  import flash.display.*;
  import flash.events.*;

  // Represents a simple toggle-switch widget with preventable default 
  // behavior.
  public class ToggleSwitch extends Sprite {
    // Stores the state of the switch
    private var isOn:Boolean;
    // Contains the toggle switch graphics
    private var icon:Sprite;
    
    // Constructor
    public function ToggleSwitch () {
      // Create the Sprite to contain the toggle switch graphics
      icon = new Sprite();
      addChild(icon);

      // Set the switch to off by default
      isOn = false;
      drawOffState();

      // Register to be notified when the user clicks the switch graphic
      icon.addEventListener(MouseEvent.CLICK, clickListener);
    }    

    // Listener executed when the user clicks the toggle switch
    private function clickListener (e:MouseEvent):void {
      // The user has attempted to turn to switch on or off, so ask 
      // ActionScript to dispatch a ToggleEvent.TOGGLE_ATTEMPT event,
      // targeted at this ToggleSwitch object. First create the event
      // object...
      var toggleEvent:ToggleEvent = 
                                new ToggleEvent(ToggleEvent.TOGGLE_ATTEMPT, 
                                                true, true);
      // ...then request the event dispatch
      dispatchEvent(toggleEvent);
      
      // The ToggleEvent.TOGGLE_ATTEMPT event dispatch is now complete. 
      // If no listener prevented the default event behavior...
      if (!toggleEvent.isDefaultPrevented()) {
        // ...then toggle the switch
        toggle();
      }
    }

    // Turns the switch on if it is currently off, or off if it is 
    // currently on. Note that the switch can be toggled programmatically,
    // even if the user does not have privileges to toggle it manually.
    public function toggle ():void {
      // Toggle the switch state
      isOn = !isOn;

      // Draw the matching graphic for the new switch state
      if (isOn) {
        drawOnState();
      } else {
        drawOffState();
      }

      // Ask ActionScript to dispatch a ToggleEvent.TOGGLE event, targeted 
      // at this ToggleSwitch object
      var toggleEvent:ToggleEvent = new ToggleEvent(ToggleEvent.TOGGLE, 
                                                    true, false, isOn);
      dispatchEvent(toggleEvent);
    }

    // Draws the graphics for the off state
    private function drawOffState ():void {
      icon.graphics.clear();
      icon.graphics.lineStyle(1);
      icon.graphics.beginFill(0xFFFFFF);
      icon.graphics.drawRect(0, 0, 20, 20);
    }

    // Draws the graphics for the on state
    private function drawOnState ():void {
      icon.graphics.clear();
      icon.graphics.lineStyle(1);
      icon.graphics.beginFill(0xFFFFFF);
      icon.graphics.drawRect(0, 0, 20, 20);
      icon.graphics.beginFill(0x000000);
      icon.graphics.drawRect(5, 5, 10, 10);
    }
  }
}