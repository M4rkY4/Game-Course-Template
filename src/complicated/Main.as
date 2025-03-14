package complicated
{
	import behaviors.Commanded;
	
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
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
		
		public function warnAboutAdvancedLayers():void
		{
			const warningText:String = "УВАГА:\nВідключіть покращені шари (AdvancedLayers) в файлі .FLA в налаштуваннях документа або не тримайте в такому шарі кнопку!";
			
			trace(warningText);
			
			var textFormat:TextFormat = new TextFormat(null, 20, 0xFF0000, true);
			var textField:TextField = new TextField();
			textField.defaultTextFormat = textFormat;
			textField.wordWrap = true;
			textField.text = warningText;
			textField.width = 400;
			textField.height = 400;
			textField.x = 20;
			textField.y = 20;
			addChild(textField);
		}
	}
}