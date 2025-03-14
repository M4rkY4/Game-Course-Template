package eng
{
	import complicated.MovieClipExtended;
	
	import flash.display.Stage;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Follower extends MovieClipExtended
	{
		private static const SPEED:Number = 1;
		
		public function Follower()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		private function onAdded(event:Event):void
		{
		
		}
		
		private function onEnterFrame(event:Event):void
		{
			followTarget();
		}
		
		private function followTarget():void
		{
			var target:Stage = main.stage;
			var targetX:Number = target.mouseX;
			var targetY:Number = target.mouseY;
			
			var posGlobal:Point = localToGlobal(new Point());
			var isAtTarget:Boolean = (targetX - posGlobal.x) * (targetX - posGlobal.x) + (targetY - posGlobal.y) * (targetY - posGlobal.y) < SPEED * SPEED;
			
			if (isAtTarget) return;
			
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
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
	}
}
