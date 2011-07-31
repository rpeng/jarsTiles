package {
  import flash.display.*;
  import flash.events.*;

  // Represents a simple toggle-switch widget
  public class ToggleSwitch extends Sprite {
    // Stores the state of the switch
    private var isOn:Boolean;
    
    // Constructor
    public function ToggleSwitch () {
      // The switch is off by default
      isOn = false;
    }    

    // Turns the switch on if it is currently off, or off if it is 
    // currently on    
    public function toggle ():void {
      // Toggle the switch state
      isOn = !isOn;
      
      // Ask ActionScript to dispatch a ToggleEvent.TOGGLE event, targeted 
      // at this ToggleSwitch object
      dispatchEvent(new ToggleEvent(ToggleEvent.TOGGLE, true, false, isOn));
    }
  }
}