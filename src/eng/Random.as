package eng
{
	import complicated.MovieClipExtended;
	
	public class Random extends MovieClipExtended
	{
		public function Random()
		{
			var randomFrameNum:Number = 1 + Math.floor(Math.random() * totalFrames);
			gotoAndPlay(randomFrameNum);
		}
	}
}
