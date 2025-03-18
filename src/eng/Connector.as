package eng
{
	import flash.display.FrameLabel;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Connector extends Controlled
	{
		private static const SUFFIX_ENTRY:String = "_1";
		private static const SUFFIX_EXIT:String = "_2";
		
		private static var _instances:Array /* of this */ = [];
		
		private var _pair:Connector;
		
		private var _isEntry:Boolean;
		private var _isExit:Boolean;
		
		public function Connector()
		{
			_instances.push(this);
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			_isEntry = name.indexOf(SUFFIX_ENTRY) != -1;
			_isExit = name.indexOf(SUFFIX_EXIT) != -1;
			
			if (_isEntry == _isExit)
			{
				trace("Зєднювач має обидва суфікси, " + SUFFIX_ENTRY + " та " + SUFFIX_EXIT);
				return;
			}
			
			connectToPair();
		}
		
		private function connectToPair():void
		{
			_pair = findPair();
			
			if (! _pair)
				return;
			
			_pair._pair = this;
			
			var entry:Connector = _isEntry ? this : _pair;
			var exit:Connector = _isExit ? this : _pair;
			
			// if no play label, we use stop-play
			var label:FrameLabel = exit.findFirstExistingLabel(Labels.ACT);
			if (! label)
				exit.stop();
			
			entry.listenToClick();
		}
		
		private function listenToClick():void
		{
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(event:MouseEvent):void
		{
			var label:FrameLabel = _pair.findFirstExistingLabel(Labels.ACT);
			
			if (label)
				_pair.gotoAndPlay(label.name);
			else
				_pair.play();
		}
		
		private function findPair():Connector
		{
			var indexIn:int = name.indexOf(SUFFIX_ENTRY);
			var indexOut:int = name.indexOf(SUFFIX_EXIT);
			
			var isIn:Boolean = indexIn != -1;
			var isOut:Boolean = indexOut != -1;
			
			if (isIn == isOut)
			{
				trace("Зєднювач: в імені " + name + " відсутній суфікс " + SUFFIX_ENTRY + " чи " + SUFFIX_EXIT + " або присутні обидва");
				return null;
			}
			
			var pairExpectedName:String = isIn
				? name.replace(SUFFIX_ENTRY, SUFFIX_EXIT)
				: name.replace(SUFFIX_EXIT, SUFFIX_ENTRY);
			
			var i:int = _instances.length;
			while (i > 0)
			{
				--i;
				var supposedPair:Connector = _instances[i];
				if (supposedPair != this && supposedPair.name == pairExpectedName)
					return supposedPair;
				
//				trace("Comparing " + pairExpectedName + " & " + supposedPair.name)
			}
			
			return null;
		}
		
		private function onRemoved(event:Event):void
		{
			if (hasEventListener(MouseEvent.CLICK))
				removeEventListener(MouseEvent.CLICK, onClick);
			
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			var indexOfMe:int = _instances.indexOf(this);
			if (indexOfMe != -1)
				_instances.splice(indexOfMe, 1);
			
			_pair = null;
		}
	}
}
