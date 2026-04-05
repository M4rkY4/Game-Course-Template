package eng
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Character extends Controlled
	{
		internal static var instance:Character;
		
		static internal var isMoving:Boolean = false;
		public static var isLeft:Boolean, isRight:Boolean, isUp:Boolean, isDown:Boolean;
		
		private static const STATE_STILL:String = "still";
		private static const STATE_WALK:String = "walk";
		
		private static const SPEED:Number = НАЛАШТУВАННЯ.ШВИДКІСТЬ_ПЕРСОНАЖА;
		
		internal var speed:Number = 5;
		
		private var _field:Field;

		private var _state:String = STATE_STILL;
		
		private var _targetX:Number, _targetY:Number;
		
		public function Character()
		{
			instance = this;

			_targetX = x;
			_targetY = y;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);

			_field = Field.instance;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			stage.addEventListener(MouseEvent.CLICK, onGameClick);
		}
		
		private function onGameClick(event:MouseEvent):void
		{
			isMoving = true;
			
			_targetX = main.mouseX;
			_targetY = main.mouseY;
			
			var posGlobal:Point = localToGlobal(new Point());
			var isAtTarget:Boolean = (_targetX - posGlobal.x) * (_targetX - posGlobal.x) + (_targetY - posGlobal.y) * (_targetY - posGlobal.y) < SPEED * SPEED;
			
			state = isAtTarget ? STATE_STILL : STATE_WALK;
			
			scaleX = Math.abs(scaleX) * (x > _targetX ? -1 : 1);
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
			if (isLeft || isRight || isUp || isDown)
			{
				state = STATE_WALK
				if (isLeft) moveX(-speed);
				if (isRight) moveX(speed);
				if (isUp) moveY(-speed);
				if (isDown) moveY(speed);
				checkFoodCollisions();
				return;
			}
			else if (state == STATE_WALK && ! isMoving)
			{
				state = STATE_STILL;
			}
			
			if (state == STATE_WALK)
			{
				followTarget();
				checkFoodCollisions();
			}
		}

		private function moveX(value:Number):void
		{
			var offsetX:Number = value > 0 ? width * .5 : -width * .5;
			var offsetY:Number = height * .5;
			
			var topPointCheck:Boolean = assertOnField(x + value + offsetX, y - offsetY);
			var bottomPointCheck:Boolean = assertOnField(x + value + offsetX, y + offsetY);

			if (topPointCheck && bottomPointCheck)
				x += value;
		}

		private function moveY(value:Number):void
		{
			var offsetX:Number = width * .5;
			var offsetY:Number = value > 0 ? height * .5 : -height * .5;
			
			var leftPointCheck:Boolean = assertOnField(x - offsetX, y + value + offsetY);
			var rightPointCheck:Boolean = assertOnField(x + offsetX, y + value + offsetY);
			
			if (leftPointCheck && rightPointCheck)
				y += value;
		}

		private function assertOnField(aX:Number, aY:Number):Boolean
		{
			if (! _field) return true;

			return _field.hitTestPoint(aX, aY, true);
		}
		
		private function checkFoodCollisions():void
		{
			var collisions:Array = Collectable.checkCollisions(this);
			if (collisions && collisions.length > 0)
				playCollision();
		}
		
		private function playCollision():void
		{
			gotoAndPlay("eat");
		}
		
		private function followTarget():void
		{
			var targetX:Number = _targetX;
			var targetY:Number = _targetY;
			
			var posGlobal:Point = localToGlobal(new Point());
			var isAtTargetX:Boolean = Math.abs(targetX - posGlobal.x) <= SPEED;
			var isAtTargetY:Boolean = Math.abs(targetY - posGlobal.y) <= SPEED;
			var isAtTarget:Boolean = isAtTargetX && isAtTargetY;
			
			if (isAtTarget)
			{
				isMoving = false;
				state = STATE_STILL;
				return;
			}
			
			if (! isAtTargetX) moveX(posGlobal.x < targetX ? SPEED : -SPEED);
			if (! isAtTargetY) moveY(posGlobal.y < targetY ? SPEED : -SPEED);
		}
		
		
		private function onRemoved(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			stage.removeEventListener(MouseEvent.CLICK, onGameClick);
		}
	}
}