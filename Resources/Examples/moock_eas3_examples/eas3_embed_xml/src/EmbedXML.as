package {
  import flash.display.*;
  import flash.events.*;
  import flash.utils.ByteArray;

  public class EmbedXML extends Sprite {
    [Embed(source="embeds/data.xml", mimeType="application/octet-stream")]
    private var BinaryData:Class;

    public function EmbedXML () {
      // Create a new instance of the embedded data
      var byteArray:ByteArray = new BinaryData();
      
      // Convert the data instance to XML
      var data:XML = new XML(byteArray.readUTFBytes(byteArray.length));
      
      // Display the source code for the embedded XML
      trace(data.toXMLString());
    }
  }
}
