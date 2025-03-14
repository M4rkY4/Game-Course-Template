package eng
{
	import complicated.MovieClipExtended;
	
	public class RandomStop extends MovieClipExtended
	{
		public function RandomStop()
		{
			var randomFrameNum:Number = 1 + Math.floor(Math.random() * totalFrames);
			gotoAndStop(randomFrameNum);
		}
	}
}
