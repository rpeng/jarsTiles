package {
  import flash.display.*;

  // A generic application that demonstrates the prevention of 
  // default behavior for custom events
  public class ControlPanel extends Sprite {
    // Set this application user's privilege level. In this example, only
    // users with UserType.ADMIN privileges can use the toggle switch.
    private var userType:int = UserType.GUEST;

    // Constructor
    public function ControlPanel () {
      // Create a ToggleSwitch
      var toggleSwitch:ToggleSwitch = new ToggleSwitch();
      // Register for ToggleEvent.TOGGLE_ATTEMPT events
      toggleSwitch.addEventListener(ToggleEvent.TOGGLE_ATTEMPT, 
                                    toggleAttemptListener);
      // Register for ToggleEvent.TOGGLE events
      toggleSwitch.addEventListener(ToggleEvent.TOGGLE, 
                                    toggleListener);
      // Add the toggle switch to this object's display hierarchy
      addChild(toggleSwitch);
    }

    // Listener executed whenever a ToggleEvent.TOGGLE_ATTEMPT event occurs
    private function toggleAttemptListener (e:ToggleEvent):void {
      // If the user is a guest...
      if (userType == UserType.GUEST) {
        // ...deny the attempted use of the toggle switch
        e.preventDefault();
      }
    }

    // Listener executed whenever a ToggleEvent.TOGGLE event occurs
    private function toggleListener (e:ToggleEvent):void {
      if (e.isOn) {
        trace("The ToggleSwitch is now on.");
      } else {
        trace("The ToggleSwitch is now off.");
      }
    }
  }
}
