package complicated
{
	import behaviors.Commanded;
	
	import flash.display.FrameLabel;
	
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.events.Event;
	
	public class Main extends Commanded
	{
		static internal var instance:Main;
		
		private var _lastStopScene:String = "";
		private var _lastStopFrame:Number = -1;
		
		public function Main()
		{
			instance = this;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			if (_lastStopScene == currentScene.name && _lastStopFrame == currentFrame)
				return;
			
			if (isFoundString(currentFrameLabel, STOPS))
			{
				_lastStopScene = currentScene.name;
				_lastStopFrame = currentFrame;
				stop();
			}
		}
		
		protected override function iterateLabels():void
		{
		
		}
		
		public static function get isAdvancedLayers():Boolean
		{
			return CONFIG::ADVANCED_LAYERS;
		}
	}
}