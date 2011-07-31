package take4 {
  import flash.display.*;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.net.URLRequest;
  import flash.geom.Rectangle;
  import flash.events.*;

  public class ImageViewer extends Sprite {
    // Loader object. Visual asset used to load image.
    private var imgLoader:Loader;

    // Border shape. Visual asset to be added to display list.
    private var border:Shape = null;

    // Border style.
    private var borderThickness:Number;
    private var borderColor:Number;

    // Outer dimensions of entire viewer (including border).
    private var w:Number;
    private var h:Number;

    // Text field in which to display download progress.
    private var loadStatus_txt:TextField;
    
    // DragManager makes the image draggable if required.
    private var dragman:DragManager;

    // Constructor
    public function ImageViewer (x:Number = 0, 
                                 y:Number = 0, 
                                 w:Number = 0, 
                                 h:Number = 0, 
                                 borderThickness:Number = 1,
                                 borderColor:Number = 0) {
      this.borderThickness = borderThickness;
      this.borderColor = borderColor;
	    
      buildViewer();
      setPosition(x, y);
      setSize(w, h);
    }

    public function loadImage (URL:String):void {
      imgLoader.load(new URLRequest(URL));

      addChild(loadStatus_txt);
      loadStatus_txt.text = "LOADING";
    }

    public function setPosition (x:Number, y:Number):void {
      this.x = x;
      this.y = y;
      // No need to redraw because setting x and y 
      // makes Flash reposition the viewer.
    }

    public function setSize (w:Number, h:Number):void {
      this.w = w;
      this.h = h;
      // If an image is already loaded, check whether it should be clipped.
      if (imgLoader.content != null && 
         (imgLoader.contentLoaderInfo.bytesLoaded
          == imgLoader.contentLoaderInfo.bytesLoaded)) {
          checkForClipping();  
      }
      draw();
    }

    private function buildViewer ():void {
      createLoader();
      createDragManager();
      createBorder();
      createStatusField();
    }
	  
    private function createLoader ():void {
      // Create the Loader instance and make it a child of this object.
      imgLoader = new Loader();
      addChild(imgLoader);
      
      // Register for events from imgLoader
      imgLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, 
                                            loadProgressListener);
      imgLoader.contentLoaderInfo.addEventListener(Event.INIT, loadInitListener);
      imgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, 
                                            loadIOErrorListener);
    }

    private function createBorder ():void {
      // Create the Loader instance and make it a child of this object.
      border = new Shape();
      addChild(border);
    }

    private function createStatusField ():void {
      loadStatus_txt = new TextField();
      loadStatus_txt.background = true;
      loadStatus_txt.border = true;
      loadStatus_txt.autoSize = TextFieldAutoSize.LEFT;
      loadStatus_txt.x = 5;
      loadStatus_txt.y = 5;
    }

    private function createDragManager ():void {
      dragman = new DragManager(imgLoader);
    }
    
    private function checkForClipping ():void {
      // If dimensions are smaller than loaded image, clip it.
      if (imgLoader.content.width > (w - borderThickness*2)
          && imgLoader.content.height > (h - borderThickness*2)) {
        dragman.setBounds(0, 0, w-borderThickness*2, h-borderThickness*2);
        dragman.enableClipping();
        dragman.activate();
      } else {
        dragman.deactivate();
      }
    }
    
    private function draw ():void {
      // Only clip image and draw border if 
      // a width and height have been specified.
      if (w > 0 && h > 0) {
        imgLoader.x = imgLoader.y = borderThickness;
      
        // Draw the border.
        var g:Graphics = border.graphics;
        g.clear();
        g.lineStyle(borderThickness, borderColor);
        g.moveTo(borderThickness/2, borderThickness/2);
        g.lineTo(w-borderThickness, borderThickness/2);
        g.lineTo(w-borderThickness, h-borderThickness);
        g.lineTo(borderThickness/2, h-borderThickness);
        g.lineTo(borderThickness/2, borderThickness/2);
      }
    }

// ===================== LOADER EVENTS ========================

    private function loadProgressListener (e:ProgressEvent):void {
      loadStatus_txt.text = "LOADING: " 
        + Math.floor(e.bytesLoaded / 1024)
        + "/" + Math.floor(e.bytesTotal / 1024) + " KB";
    }
    
    private function loadInitListener (e:Event):void {
      removeChild(loadStatus_txt);
      checkForClipping();
    }
    
    private function loadIOErrorListener (e:IOErrorEvent):void {
      // Tell the user the image didn't load.
      loadStatus_txt.text = "ERROR LOADING IMAGE" 
    }
  }
}









