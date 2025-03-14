package eng
{
	import complicated.Main;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Button extends SimpleButton
	{
		public function Button()
		{
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		private function onClick(event:MouseEvent):void
		{
			var parentMC:MovieClip = Main.isAdvancedLayers
				? parent.parent as MovieClip
				: parent as MovieClip;
			
			if (parentMC /*&& parentMC.currentFrame < parentMC.totalFrames*/) parentMC.play();
			/** @link https://helpx.adobe.com/au/animate/using/timeline-layers.html */
		}
		
		private function removedFromStageHandler(event:Event):void
		{
			removeEventListener(MouseEvent.CLICK, onClick);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
	}
}
