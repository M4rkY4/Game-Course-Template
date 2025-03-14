package complicated
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	
	public class SimpleButtonExtended extends SimpleButton
	{
		public function SimpleButtonExtended()
		{
		}
		
		static internal function get main():MovieClip { return Main.instance }
	}
}
