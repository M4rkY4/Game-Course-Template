package eng
{
	import complicated.MovieClipExtended;
	
	public class Field extends MovieClipExtended
	{
		private static var _instance:Field;
		public static function get instance():Field
		{
			return _instance;
		}
		
		public function Field()
		{
			_instance = this;
			alpha = 0;
		}
	}
}