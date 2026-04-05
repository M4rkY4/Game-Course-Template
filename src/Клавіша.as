package
{
	import eng.ControlKey;
	
	public class Клавіша extends ControlKey
	{
		public function Клавіша()
		{
			if (name == "вліво") left = this;
			if (name == "вправо") right = this;
			if (name == "вгору") up = this;
			if (name == "вниз") down = this;
			super();
		}
	}
}
