package {
  import flash.events.*;

  // A class representing the custom "toggle" event
  public class ToggleEvent extends Event {
    // A constant for the "toggle" event type
    public static const TOGGLE:String = "toggle";

    // A constant for the "toggleAttempt" event type
    public static const TOGGLE_ATTEMPT:String = "toggleAttempt";
    
    // Indicates whether the switch is now on or off
    public var isOn:Boolean;
    
    // Constructor
    public function ToggleEvent (type:String,
                                 bubbles:Boolean = false,
                                 cancelable:Boolean = false,
                                 isOn:Boolean = false) {
      // Pass constructor parameters to the superclass constructor
      super(type, bubbles, cancelable);
      
      // Store the toggle switch's state so it can be accessed within
      // ToggleEvent.TOGGLE listeners
      this.isOn = isOn;
    }

    // Every custom event class must override clone()
    public override function clone():Event {
      return new ToggleEvent(type, bubbles, cancelable, isOn);
    }

    // Every custom event class must override toString().
    public override function toString():String { 
      return formatToString("ToggleEvent", "type", "bubbles",
                            "cancelable", "eventPhase", "isOn");
    }
  }
}