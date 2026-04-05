package eng
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Character extends Controlled
	{
		internal static var instance:Character;
		
		static internal var isLeft:Boolean = false;
		static internal var isRight:Boolean = false;
		static internal var isUp:Boolean = false;
		static internal var isDown:Boolean = false;
		
		static internal var isLeftAvailable:Boolean = false;
		static internal var isRightAvailable:Boolean = false;
		static internal var isUpAvailable:Boolean = false;
		static internal var isDownAvailable:Boolean = false;
		
		static internal var isMoving:Boolean = false;
		
		private static const STATE_STILL:String = "still";
		private static const STATE_WALK:String = "walk";
		
		private static const SPEED:Number = НАЛАШТУВАННЯ.ШВИДКІСТЬ_ПЕРСОНАЖА;
		
		internal var speed:Number = 5;
		
		private var _state:String = STATE_STILL;
		
		private var _targetX:Number;
		private var _targetY:Number;
		
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
			checkWallCollisions();
			
			isLeft = isLeft && isLeftAvailable;
			isRight = isRight && isRightAvailable;
			isUp = isUp && isUpAvailable;
			isDown = isDown && isDownAvailable;
			
			if (isLeft || isRight || isUp || isDown)
			{
				state = STATE_WALK
				if (isLeft) x -= speed;
				if (isRight) x += speed;
				if (isUp) y -= speed;
				if (isDown) y += speed;
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
		
		private function checkWallCollisions():void
		{
			isLeftAvailable = isRightAvailable = isUpAvailable = isDownAvailable = true;
			
			var obstacles:Array = Obstacle._obstaclesActive;
			
			var i:int = obstacles.length;
			while (i > 0)
			{
				--i;
				var obstacle:Obstacle = obstacles[i];
				if (this.hitTestObject(obstacle))
				{
					isLeftAvailable = isLeftAvailable && ! obstacle.hitTestPoint(x - 40, y);
					isRightAvailable = isRightAvailable && ! obstacle.hitTestPoint(x + 40, y);
					isUpAvailable = isUpAvailable && ! obstacle.hitTestPoint(x, y - 60);
					isDownAvailable = isDownAvailable && ! obstacle.hitTestPoint(x, y + 60);
				}
			}
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
			var isAtTarget:Boolean = (targetX - posGlobal.x) * (targetX - posGlobal.x) + (targetY - posGlobal.y) * (targetY - posGlobal.y) < SPEED * SPEED;
			
			if (isAtTarget)
			{
				isMoving = false;
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
			
			if (! isLeftAvailable && speedLocal.x < 0) speedLocal.x = 0;
			if (! isRightAvailable && speedLocal.x > 0) speedLocal.x = 0;
			if (! isUpAvailable && speedLocal.y < 0) speedLocal.y = 0;
			if (! isDownAvailable && speedLocal.y > 0) speedLocal.y = 0;
			
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