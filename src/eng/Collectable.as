package eng
{
	import behaviors.Commanded;
	
	import flash.display.FrameLabel;
	
	import flash.display.MovieClip;
	
	import flash.events.Event;
	
	public class Collectable extends Commanded
	{
		protected static const LABELS_OFF:Array /* of String */ = ["off", "OFF", "колізія", "нема"];
		
		private static var _instances:Array /* of Collectable */ = [];
		
		public static function checkCollisions(target:MovieClip):Array /* of Collectable */
		{
			if (! target) return [];
			
			var result:Array = [];
			
			for each(var collectable:Collectable in _instances)
			{
				if (collectable._state == STATE_ON && target.hitTestObject(collectable))
				{
					collectable.onCollided();
					result.push(collectable);
				}
			}
			
			return result;
		}
		
		
		private static const STATE_ON:String = "on";
		private static const STATE_OFF:String = "off";
		private var _state:String = STATE_ON;
		
		public function Collectable()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			_instances.push(this);
		}
		
		private function onCollided():void
		{
			if (_state == STATE_OFF) return;
			
			_state = STATE_OFF;
			
			var label:FrameLabel = findFirstExistingLabel(LABELS_OFF);
			
			if (label)
				gotoAndPlay(label.name);
			else
				visible = false;
		}
		
		private function onRemoved(event:Event):void
		{
			_instances.splice(_instances.indexOf(this), 1);
			
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
	}
}
