package {
  import flash.display.*;
  import flash.text.*;
  import flash.events.*;
  import flash.net.*;

  public class StyleSheetLoadingDemo extends Sprite {
    private var bookStyle:StyleSheet;
    private var styleSource:String;
    private var bookContent:XML;
    
    public function StyleSheetLoadingDemo () {
      var urlLoader:URLLoader = new URLLoader();
      urlLoader.addEventListener(Event.COMPLETE, completeListener);
      urlLoader.load(new URLRequest("styles.css"));

      bookContent = <BOOK>
        <H1>ActionScript Basics</H1>
        <P>This chapter covers the following topics:</P>
        <LI>variables</LI>
        <LI w="foo">functions</LI>
        <P>To create a variable, we use the keyword <CODE>var</CODE>. 
           The following code demonstrates:</P>
        <EXAMPLE>var x:int = 10;</EXAMPLE>
        <P>For more information, visit
           <A HREF="http://moock.org/eas3">this web site</A>.</P>
        </BOOK>


    }

    private function completeListener (e:Event):void {
      styleSource = e.target.data;
      start();
    }

    private function start ():void {
      bookStyle = new StyleSheet();
      bookStyle.parseCSS(styleSource);

      var t:TextField = new TextField();
      t.multiline = true;
      t.wordWrap = true;
      t.styleSheet = bookStyle;
      t.width = 400;
      t.height = 300;
      t.border     = true;
      t.background = true;
      t.condenseWhite = true;
      t.htmlText = bookContent.toXMLString();

      addChild(t);
    }
  }
}
