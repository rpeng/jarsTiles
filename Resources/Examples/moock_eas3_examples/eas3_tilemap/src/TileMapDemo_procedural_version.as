// -object-oriented version is more self-documenting
// -function performing a task for some 'thing' indicates need for class
// -class's responsibilities should pertain to one 'thing'


package {
  import flash.display.*;
  import flash.util.*;
  import flash.events.*;
  import flash.net.*;  
  import flash.geom.*
  
  public class TileMapDemo extends Sprite {
    private var tileData:BitmapData;
    private var tiles:Array;  // Array of ByteArrays
    private var tileSize:int = 8;
    
    private var worldMap:Array;
    private var worldMapNumCols:int;
    private var worldMapNumRows:int;
    
    private var mapBuffer:BitmapData;
    private var mapBitmap:Bitmap;
    
    private var cropX:int = 0;
    private var cropY:int = 0;
    private var cropW:int = 160;
    private var cropH:int = 160;
    
    private var lastMouseX:Number;
    private var lastMouseY:Number;
    
    public function TileMapDemo () {
      // Prevent the app from resizing
      stage.scaleMode = StageScaleMode.NO_SCALE;
      loadTiles();
    }

    public function start ():void {
      generateRandomWorldMap(250, 250);

      var pixel:BitmapData = new BitmapData(1, 1);
      mapBitmap = new Bitmap(pixel);
      addChild(mapBitmap);

      displayMap(cropX, cropY, cropW, cropH);
      stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener);
      stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
    }

    public function mouseDownListener (e:MouseEvent):void {
      lastMouseX = e.stageX;
      lastMouseY = e.stageY;
    }
    
    public function mouseMoveListener (e:MouseEvent):void {
      if (e.buttonDown) {
        var moveX:int = e.stageX - lastMouseX;
        var moveY:int = e.stageY - lastMouseY;
        cropX -= moveX;
        cropY -= moveY;

        var maxCropX:int = worldMapNumCols*tileSize - cropW;
        if (cropX > maxCropX) {
          cropX = maxCropX;
        } else if (cropX < 0) {
          cropX = 0;
        }
        var maxCropY:int = worldMapNumRows*tileSize - cropH;
        if (cropY > maxCropY) {
          cropY = maxCropY;
        } else if (cropY < 0) {
          cropY = 0;
        }

        lastMouseX = e.stageX;
        lastMouseY = e.stageY;

        displayMap(cropX, cropY, cropW, cropH);
        e.updateAfterEvent();
      }
    }

    private function generateRandomWorldMap (cols:int, rows:int):void {
      worldMapNumCols = cols;
      worldMapNumRows = rows;
      worldMap = new Array();
      for (var i:int = 0; i < rows; i++) {
        worldMap[i] = new Array();
        for (var j:int = 0; j < cols; j++) {
          worldMap[i][j] = Math.floor(Math.random()*tiles.length);
//          worldMap[i][j] = j%tiles.length;
        }
      }
    }

    public function displayMap (x:int, y:int, width:int, height:int):void {
      // If necessary, adjust width and height to ensure that the display 
      // region displays at least one tile.
      if (width < tileSize) {
        width = tileSize;
      } 
      if (height < tileSize) {
        height = tileSize;
      } 
      // If necessary, adjust width and height to ensure that the display 
      // region does not exceed the size of the world map.
      if (width > worldMapNumCols*tileSize) {
        width = worldMapNumCols*tileSize;
      } 
      if (height > worldMapNumRows*tileSize) {
        height = worldMapNumRows*tileSize;
      } 
      // If necessary, adjust x and y to ensure that the display region
      // is always within the bounds of the world map.
      if (x < 0) {
        x = 0;
      }
      if (y < 0) {
        y = 0;
      }
      if (x+width > worldMapNumCols*tileSize) {
        x = worldMapNumCols*tileSize - width;
      }
      if (y+height > worldMapNumRows*tileSize) {
        y = worldMapNumRows*tileSize - height;
      }

      var xOffset:int  = x%tileSize;
      var yOffset:int  = y%tileSize;
      var startCol:int = Math.floor(x/tileSize);
      var startRow:int = Math.floor(y/tileSize);
      var numCols:int  = Math.ceil((width+xOffset)/tileSize);
      var numRows:int  = Math.ceil((height+yOffset)/tileSize);
      
      mapBuffer = makeBuffer(startCol, startRow, numCols, numRows);
      mapBuffer.scroll(-xOffset, -yOffset); 

      mapBitmap.bitmapData = mapBuffer;
      // ##[todo: check for redundancy...]
      // ##[todo: report scrollRect bug (not working on bitmaps after init fires until screen refresh)]
      scrollRect = new Rectangle(0, 0, width, height);
    }
    
    
    private function makeBuffer (startCol:int, startRow:int, 
                                 numCols:int, numRows:int):BitmapData {
      var buff:BitmapData = new BitmapData(numCols * tileSize,
                                           numRows * tileSize);
      var endCol:int = startCol + numCols;
      var endRow:int = startRow + numRows;
      
      for (var i:int = startRow; i < endRow; i++) {
        for (var j:int = startCol; j < endCol; j++) {
          // ##[use the real setPixels() when it's fixed]
          // ##[report setPixels() bug]
          setPixels(buff, new Rectangle((j-startCol)*tileSize, 
                                        (i-startRow)*tileSize, 
                                         tileSize, tileSize), 
                                         tiles[worldMap[i][j]]);
        }
      }
      return buff;
    }

    public function loadTiles ():void {
      var l:Loader = new Loader();
      l.addEventListener(Event.OPEN, tileOpenListener);
      l.addEventListener(ProgressEvent.PROGRESS, tileProgressListener);
      l.addEventListener(Event.INIT, tileInitListener);
      l.addEventListener(IOErrorEvent.IO_ERROR, tileIoErrorListener);
      l.load(new URLRequest("spacetiles.gif"));

      // Prevent the app from resizing
      stage.scaleMode = StageScaleMode.NO_SCALE;
    }

    // Split graphic into tiles.
    public function processTiledata (size:int, 
                                     data:BitmapData):Array {
      var tiles:Array = new Array();
      var numTilesH:int = data.width/size;
      var numTilesV:int = data.height/size;
      
      for (var i:int = 0; i < numTilesV; i++) {
        for (var j:int = 0; j < numTilesH; j++) {
          // ##[use the real getPixels() when it's fixed]
//        tiles.push(data.getPixels(new Rectangle(j*size, i*size,
//                                                       size, size)));
          tiles.push(getPixels(data, new Rectangle(j*size, i*size, size, size)));
        }
      }
      return tiles;
    }

    private function tileOpenListener (e:Event):void {
      trace("load started");
    }
    
    private function tileProgressListener (e:ProgressEvent):void {
      trace("LOADING: " 
        + Math.floor(e.bytesLoaded / 1024)
        + "/" + Math.floor(e.bytesTotal / 1024) + " KB");
    }
    
    private function tileInitListener (e:Event):void {
      trace("load complete");
      tiles = processTiledata(tileSize, e.target.content.bitmapData);
      start();
    }
    
    private function tileIoErrorListener (e:IOErrorEvent):void {
      trace("load error");
    }
    
    private function getPixels (data:BitmapData, rect:Rectangle):ByteArray {
      var pixels:ByteArray = new ByteArray();
      for (var i:int = rect.y; i < rect.bottom; i++) {
        for (var j:int = rect.x; j < rect.right; j++) {
          pixels.writeUnsignedInt(data.getPixel32(j, i));
        }
      }
      return pixels;
    }
    
    private function setPixels (data:BitmapData,
                                rect:Rectangle, 
                                pixels:ByteArray):void {
      var origPosition:int = pixels.position;
      pixels.position = 0;
      for (var i:int = rect.y; i < rect.bottom; i++) {
       for (var j:int = rect.x; j < rect.right; j++) {
          data.setPixel(j, i, pixels.readUnsignedInt());
        }
      }
      pixels.position = origPosition;
    }
  } 
}
