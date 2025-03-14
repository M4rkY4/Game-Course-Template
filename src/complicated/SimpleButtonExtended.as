package complicated
{
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;
	
	public class SimpleButtonExtended extends SimpleButton
	{
		public function SimpleButtonExtended()
		{
		}
		
		protected function parentNonLayer():DisplayObjectContainer
		{
			var result:DisplayObjectContainer = parent;
			if (! result) return null;
			
			if (result.name.indexOf("Layer_") == 0)
			{
				main.warnAboutAdvancedLayers();
				result = result.parent;
			}
			
			return result ? result : parent;
		}
		
		static internal function get main():Main { return Main.instance }
	}
}
