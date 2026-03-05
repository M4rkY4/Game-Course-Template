package eng
{
	import complicated.MovieClipExtended;
	
	import eng.Labels;
	
	import flash.display.FrameLabel;
	
	public class Controlled extends MovieClipExtended
	{
		
		
		public function Controlled()
		{
			iterateLabels();
		}
		
		protected function iterateLabels():void
		{
			for each (var label:FrameLabel in currentLabels)
				processLabel(label);
			
//			for each (label in this.currentLabels)
//				trace(label.name);
		}
		
		protected function processLabel(label:FrameLabel):void
		{
			if (isFound(label, Labels.STOPS))
			{
				addFrameScript(label.frame - 1, stop);
//				trace("Added stops at " + label.frame);
				return;
			}
			
			if (isFound(label, Labels.REWINDS))
			{
				addFrameScript(label.frame - 1, rewind);
				return;
			}
			
			if (isFound(label, Labels.EXEC))
			{
				trace("EXEC FND");
				addFrameScript(label.frame - 1, executeCustom);
				return;
			}
			
			var param:String = isFoundWithParam(label, Labels.LOOP);
			if (param)
			{
				addFrameScript(label.frame - 1, function loop():void
				{
					gotoAndPlay(param);
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
		
		protected function findFirstExistingLabel(labelsToSearch:Array /* of String */):FrameLabel
		{
			for each (var label:FrameLabel in currentLabels)
				for each (var labelName:String in labelsToSearch)
					if (label.name.substr(0, labelName.length) == labelName)
						return label;
			
			return null;
		}
		
		protected function executeCustom():void
		{
		
		}
		
		protected function rewind():void { gotoAndStop(1); }
	}
}
