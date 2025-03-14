package eng
{
	import complicated.MovieClipExtended;
	
	import flash.events.Event;
	
	import flash.text.TextField;
	
	public class Counter extends MovieClipExtended
	{
		private var _tf:TextField;
		private var current:Number = 0;
		private var target:Number;
		
		public function Counter()
		{
			_tf = this["tf"];
			if (! _tf)
				return;
			
			target = Number(_tf.text);
			
			if (isNaN(target) || target < 1)
			{
				_tf = null;
				return;
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		private function onEnterFrame(event:Event):void
		{
			current++;
			
			_tf.text = String((current >= target) ? target : current);
			
			if (current >= target)
				remove();
		}
		
		private function onRemoved(event:Event):void
		{
			remove();
		}
		
		private function remove():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
	}
}
