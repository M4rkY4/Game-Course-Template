package eng
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Character extends Controlled
	{
		private static const STATE_STILL:String = "still";
		private static const STATE_WALK:String = "walk";
		
		private static const SPEED:Number = НАЛАШТУВАННЯ.ШВИДКІСТЬ_ПЕРСОНАЖА;
		
		private var _state:String = STATE_STILL;
		
		private var _targetX:Number;
		private var _targetY:Number;
		
		public function Character()
		{
			_targetX = x;
			_targetY = y;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			stage.addEventListener(MouseEvent.CLICK, onGameClick);
		}
		
		private function onGameClick(event:MouseEvent):void
		{
			_targetX = main.mouseX;
			_targetY = main.mouseY;
			
			var posGlobal:Point = localToGlobal(new Point());
			var isAtTarget:Boolean = (_targetX - posGlobal.x) * (_targetX - posGlobal.x) + (_targetY - posGlobal.y) * (_targetY - posGlobal.y) < SPEED * SPEED;
			
			state = isAtTarget ? STATE_STILL : STATE_WALK;
		}
		
		private function set state(value:String):void
		{
			if (_state == value) return;
			
			_state = value;
			gotoAndPlay(value);
		}
		
		private function get state():String
		{
			return _state;
		}
		
		private function onEnterFrame(event:Event):void
		{
			if (state == STATE_WALK)
			{
				followTarget();
				Collectable.checkCollisions(this);
			}
		}
		
		private function followTarget():void
		{
			var targetX:Number = _targetX;
			var targetY:Number = _targetY;
			
			var posGlobal:Point = localToGlobal(new Point());
			var isAtTarget:Boolean = (targetX - posGlobal.x) * (targetX - posGlobal.x) + (targetY - posGlobal.y) * (targetY - posGlobal.y) < SPEED * SPEED;
			
			if (isAtTarget)
			{
				state = STATE_STILL;
				return;
			}
			
			var speedGlobal:Point = new Point();
			if (Math.abs(targetX - posGlobal.x) < SPEED)
				speedGlobal.x = 0;
			else
				speedGlobal.x = targetX > posGlobal.x ? SPEED : -SPEED;
			
			if (Math.abs(targetY - posGlobal.y) < SPEED)
				speedGlobal.y = 0;
			else
				speedGlobal.y = targetY > posGlobal.y ? SPEED : -SPEED;
			
			var speedLocal:Point = parent.globalToLocal(speedGlobal);
			x += speedLocal.x;
			y += speedLocal.y;
		}
		
		
		private function onRemoved(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			stage.removeEventListener(MouseEvent.CLICK, onGameClick);
		}
	}
}