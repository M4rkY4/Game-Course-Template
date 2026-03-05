package eng
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Draggable extends MovieClip
	{
		public function Draggable()
		{
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			this.startDrag();
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			this.stopDrag();
		}
		
		private function onRemoved(event:Event):void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
	}
}
