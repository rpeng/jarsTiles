package logger {
  
  /**
   * A log message. Sent by the the Logger to all registered
   * log observers when a new log message is generated.
   */
  public class LogMessage {
    // The text of the message sent to the log.
    private var msg:String;
    // The severity level of this message.
    private var level:Number;
  
    /**
     * LogMessage Constructor
     */
    public function LogMessage (m:String, lev:Number) {
      setMessage(m);
      setLevel(lev);
    }
  
    /**
     * Sets the log message.
     */
    public function setMessage (m:String):void {
      msg = m;
    }
  
    /**
     * Returns the log message.
     */
    public function getMessage ():String {
      return msg;
    }
  
    /**
     * Sets the severity level for this message.
     */
    public function setLevel (lev:Number):void {
      level = lev;
    }
  
    /**
     * Returns the severity level for this message.
     */
    public function getLevel ():Number {
      return level;
    }
  }
}