package eng
{
	import eng.Character;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class ControlKey extends Controlled
	{
		static protected var left:ControlKey;
		static protected var right:ControlKey;
		static protected var up:ControlKey;
		static protected var down:ControlKey;
		
		public function ControlKey()
		{
			if (name == "left") left = this;
			if (name == "right") right = this;
			if (name == "up") up = this;
			if (name == "down") down = this;
			
			if (this == left || this == right || this == up || this == down)
				addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(MouseEvent.MOUSE_UP, onUp);
			addEventListener(MouseEvent.CLICK, onClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		private function onDown(event:MouseEvent):void
		{
			event.preventDefault();
			event.stopPropagation();
			
			if (this == left) Character.isLeft = true;
			if (this == right) Character.isRight = true;
			if (this == up) Character.isUp = true;
			if (this == down) Character.isDown = true;
		}
		
		private function onUp(event:MouseEvent):void
		{
			event.preventDefault();
			event.stopPropagation();
			
			if (this == left) Character.isLeft = false;
			if (this == right) Character.isRight = false;
			if (this == up) Character.isUp = false;
			if (this == down) Character.isDown = false;
			
			Character.isMoving = Character.isLeft && Character.isRight && Character.isUp && Character.isDown;
		}
		
		private function onClick(event:MouseEvent):void
		{
			event.preventDefault();
			event.stopPropagation();
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			var character:Character = Character.instance;
			if (! character || ! character.stage)
				return;
			
			if (event.keyCode == Keyboard.LEFT) Character.isLeft = true;
			if (event.keyCode == Keyboard.RIGHT) Character.isRight = true;
			if (event.keyCode == Keyboard.UP) Character.isUp = true;
			if (event.keyCode == Keyboard.DOWN) Character.isDown = true;
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			var character:Character = Character.instance;
			if (! character || ! character.stage)
			{
				Character.isLeft = Character.isRight = Character.isUp = Character.isDown = false;
				return;
			}
			
			if (event.keyCode == Keyboard.LEFT) Character.isLeft = false;
			if (event.keyCode == Keyboard.RIGHT) Character.isRight = false;
			if (event.keyCode == Keyboard.UP) Character.isUp = false;
			if (event.keyCode == Keyboard.DOWN) Character.isDown = false;
			
			Character.isMoving = Character.isLeft && Character.isRight && Character.isUp && Character.isDown;
		}
		
		private function moveCharacter():void
		{
			var character:Character = Character.instance;
			if (! character || ! character.stage)
				return;
			
			if (this == left) character.x -= character.speed;
			if (this == right) character.x += character.speed;
			if (this == up) character.y -= character.speed;
			if (this == down) character.y += character.speed;
		}
		
		private function onRemoved(event:Event):void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			removeEventListener(MouseEvent.MOUSE_UP, onUp);
			removeEventListener(MouseEvent.CLICK, onClick);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
	}
}
