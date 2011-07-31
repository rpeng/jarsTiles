package {
  // This is the sheltered class
  public class ShelteredClass {
    // The namespace restricted qualifies properties and 
    // methods to which access is restricted
    private namespace restricted;

    // This is the array of authorized classes. In this
    // example there is only one authorized class: Caller.
    private var authorizedClasses:Array = [ Caller ];
    
    // This is a restricted property.
    // It can be accessed by authorized classes only
    restricted var secretData:String = "No peeking";
    
    // This is a restricted method.
    // It can be accessed by authorized classes only        
    restricted function secretMethod ():void { 
      trace("Restricted method secretMethod() called");
    } 

    public function getRestrictedNamespace 
                                  (callerObject:Object):Namespace {
      // Check to see if the callerObject is in the authorizedClasses array.
      for each (var authorizedClass:Class in authorizedClasses) {
        // If the caller object is an instance of an authorized class...
        if (callerObject is authorizedClass) {
          // ...pass back a reference to the restricted namespace (the
          // keys to the front door)
          return restricted;
        }
      }
      // The caller object is not an instance of 
      // an authorized class, so abort
      return null;
    }
  }
}
