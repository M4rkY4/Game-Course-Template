package eng
{
	import complicated.MovieClipExtended;
	
	import flash.text.TextField;
	
	public class CollectedCounter extends MovieClipExtended
	{
		public static function get instance():CollectedCounter
		{
			return _instance;
		}
		
		private static var _instance:CollectedCounter;
		
		static public function increment():void
		{
			if (_instance)
				_instance.count++;
		}
		
		private var _count:int = 0;
		private var _textfield:TextField;
		
		public function CollectedCounter()
		{
			_instance = this;
			
			_textfield = this["tf"];
		}
		
		public function set count(value:int):void
		{
			_count = value;
			_textfield.text = String(_count);
		}
		
		public function get count():int
		{
			return _count;
		}
	}
}
