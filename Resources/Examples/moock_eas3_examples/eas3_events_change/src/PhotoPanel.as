package {
  import flash.display.*;
  import flash.events.*;
  import flash.text.*;  

  // Partial example of a panel widget containing nameable photos. 
  // This code excerpt shows how to keep the panel title bar
  // updated to match the name of the currently selected photo. 
  // For demonstration purposes, only one photo's title is shown.
  public class PhotoPanel extends Sprite {
    private static const defaultTitle:String = 
                                         "Photo Viewer [No photo selected]";
    private static const defaultPhotoName:String = 
                                         "Enter Photo Name Here";
    
    private var title:TextField;    
    private var photoname:TextField;
    
    public function PhotoPanel () {
      // Create the TextField object for the panel's title bar
      title = new TextField();
      title.text = PhotoPanel.defaultTitle;
      title.width  = 350;
      title.height = 25;
      title.border     = true;
      title.background = true;
      title.selectable = false;
      addChild(title);

      // Create a title TextField object for an individual photo
      photoname = new TextField();
      photoname.text = PhotoPanel.defaultPhotoName;
      photoname.width  = 150;
      photoname.height = 30;
      photoname.x = 100;
      photoname.y = 150;
      photoname.border     = true;
      photoname.background = true;
      photoname.type = TextFieldType.INPUT
      addChild(photoname);


      // Register with photoname for Event.CHANGE events
      photoname.addEventListener(Event.CHANGE, changeListener);
      
      // Register with photoname for focus in and out events      
      photoname.addEventListener(FocusEvent.FOCUS_IN, photoFocusInListener);
      photoname.addEventListener(FocusEvent.FOCUS_OUT, 
                                 photoFocusOutListener);

      // Register with the stage for focus out events                                    
      stage.addEventListener(FocusEvent.FOCUS_OUT, panelFocusOutListener);
    }

    // Triggered whenever new text is added to photoname
    private function changeListener (e:Event):void {
      // The photo's name changed, so update title to match photoname's text
      if (photoname.text.length == 0) {
        title.text = "Photo Viewer [Unnamed Photo]";
      } else {
        title.text = "Photo Viewer [" + photoname.text + "]";
      }
    }

    // Triggered whenever photoname gains focus
    private function photoFocusInListener (e:FocusEvent):void {
      // If the photo hasn't been named yet...
      if (photoname.text == PhotoPanel.defaultPhotoName) {
        // ...clear the photoname text field so the user can enter a name
        photoname.text = "";
        // Update the panel title to indicate that an unnamed photo is
        // selected
        title.text = "Photo Viewer [Unnamed Photo]";
      } else {
        // ...the selected photo already has a name, so update the panel 
        // title to display that name
        title.text = "Photo Viewer [" + photoname.text + "]";
      }
    }

    // Triggered whenever photoname loses focus
    private function photoFocusOutListener (e:FocusEvent):void {
      // If the user didn't enter a name for the photo...
      if (photoname.text.length == 0) {
        // ...set the photo's name to the default value
        photoname.text = PhotoPanel.defaultPhotoName;
      }
    }

    // Triggered whenever any object loses focus
    private function panelFocusOutListener (e:FocusEvent):void {
      // If no object is currently focused...
      if (e.relatedObject == null) {
        // ...set the panel title to the default value
        title.text = PhotoPanel.defaultTitle;
      }
    }
  }
}
