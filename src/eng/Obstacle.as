package eng
{
	import complicated.MovieClipExtended;
	
	import flash.events.Event;
	
	public class Obstacle extends MovieClipExtended
	{
		static const _obstaclesActive:Array /* of this */ = [];
		
		public function Obstacle()
		{
			visible = false;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			if (_obstaclesActive.indexOf(this) == -1)
				_obstaclesActive.push(this);
		}
		
		private function onRemoved(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			var index:int = _obstaclesActive.indexOf(this);
			if (index != -1)
				_obstaclesActive.splice(index, 1);
		}
	}
}
