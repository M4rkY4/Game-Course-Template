package eng
{
	import complicated.MovieClipExtended;
	
	import flash.events.Event;
	
	import flash.events.MouseEvent;
	
	public class Clip extends MovieClipExtended
	{
		public function Clip()
		{
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		private function onClick(event:MouseEvent):void
		{
			play();
		}
		
		private function removedFromStageHandler(event:Event):void
		{
			removeEventListener(MouseEvent.CLICK, onClick);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
	}
}
