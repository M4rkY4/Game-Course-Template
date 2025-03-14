package complicated
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	public class MovieClipExtended extends MovieClip
	{
		public function MovieClipExtended()
		{
		}
		
		protected function get parentNonLayer():DisplayObjectContainer
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
		
		static protected function get main():Main { return Main.instance }
	}
}
