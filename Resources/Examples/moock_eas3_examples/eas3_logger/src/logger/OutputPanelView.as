package logger {
  import util.Observer;
  import util.Observable;
  
  /**
   * An observer of the Logger class. When a movie is played in 
   * the Flash authoring tool's Test Movie mode, this class displays
   * log messages in the Output panel.
   */
  public class OutputPanelView implements Observer {
    // The log that this object is observing.
    private var log:Logger;
  
    /**
     * Constructor
     */
    public function OutputPanelView (l:Logger) {
      log = l;
    }
  
    /**
     * Invoked when the log changes. For details, see the 
     * Observer interface.
     */
    public function update (o:Observable, infoObj:Object):void {
      // Cast infoObj to a LogMessage instance for type checking.
      var logMsg:LogMessage = LogMessage(infoObj);
      trace(Logger.getLevelDesc(logMsg.getLevel()) + ": " + logMsg.getMessage());
    }
  
    public function destroy ():void {
      log.removeObserver(this);
    }
  }
}