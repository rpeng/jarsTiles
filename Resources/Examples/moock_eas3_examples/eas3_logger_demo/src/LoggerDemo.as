package {
	import flash.display.Sprite;
  import logger.*;

	public class LoggerDemo extends Sprite {
		public function LoggerDemo() {

      // Create log and observers.
      var log:Logger;
      log = Logger.getLog();
      var outputLogView:OutputPanelView;
      outputLogView = new OutputPanelView(log);
      log.addObserver(outputLogView);

      // Test the log out.
      log.fatal("This is a non-recoverable problem.");
      log.error("This is a serious problem that may be recoverable.");
      log.warn("This is something to look into, but probably isn't serious.");
      log.info("This is a general bit of application information.");

      // This won't appear because the log instance defaults
      // to log level "INFO", which filters out debug messages.
      log.debug("This is a note that helps track down a bug.");

      // If we change the log level to "DEBUG"...
      log.setLevel(Logger.DEBUG);

      // ...then debug messages appear.
      log.debug("Just testing!");
		}
	}
}
