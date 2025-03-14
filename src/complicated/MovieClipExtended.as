package complicated
{
	import flash.display.MovieClip;
	
	public class MovieClipExtended extends MovieClip
	{
		public function MovieClipExtended()
		{
		}
		
		static internal function get main():MovieClip { return Main.instance }
	}
}
