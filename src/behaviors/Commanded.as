package behaviors
{
	import complicated.MovieClipExtended;
	
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	
	public class Commanded extends MovieClipExtended
	{
		protected static const STOPS:Array /* of String */ = ["stop", "стоп", "STOP", "СТОП"];
		protected static const REWINDS:Array /* of String */ = ["rewind", "перемотка", "REWIND", "ПЕРЕМОТКА"];
		protected static const LOOP:Array /* of String */ = ["loop", "цикл", "LOOP", "ЦИКЛ"];
		
		public function Commanded()
		{
			iterateLabels();
		}
		
		protected function iterateLabels():void
		{
			for each (var label:FrameLabel in this.currentLabels)
				trace(label.name);
			
			for each (label in this.currentLabels)
				processLabel(label);
		}
		
		protected function processLabel(label:FrameLabel):void
		{
			if (isFound(label, STOPS))
			{
				addFrameScript(label.frame - 1, stop);
//				trace("Added stops at " + label.frame);
				return;
			}
			
			if (isFound(label, REWINDS))
			{
				addFrameScript(label.frame - 1, rewind);
				return;
			}
			
			var param:String = isFoundWithParam(label, LOOP);
			if (param)
			{
				addFrameScript(label.frame - 1, function loop():void
				{
					gotoAndStop(param);
				});
				return;
			}
		}
		
		protected function isFound(label:FrameLabel, labelsToSearch:Array /* of String */):Boolean
		{
			for each (var labelName:String in labelsToSearch)
				if (label.name.substr(0, labelName.length) == labelName)
					return true;
			
			return false;
		}
		
		protected function isFoundString(label:String, labelsToSearch:Array /* of String */):Boolean
		{
			for each (var labelName:String in labelsToSearch)
				if (label && label.substr(0, labelName.length) == labelName)
					return true;
			
			return false;
		}
		
		protected function isFoundWithParam(label:FrameLabel, labelsToSearch:Array /* of String */):String
		{
			for each (var labelName:String in labelsToSearch)
				if (label.name.substr(0, labelName.length) == labelName)
					return label.name.substring(labelName.length, label.name.length);
			
			return null;
		}
		
		protected function rewind():void { gotoAndStop(1); }
	}
}
