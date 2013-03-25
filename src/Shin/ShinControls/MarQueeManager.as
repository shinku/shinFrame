package Shin.ShinControls
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class MarQueeManager extends Sprite
	{
		public var marquees:Vector.<Marquee>;
		public function MarQueeManager()
		{
			marquees=new Vector.<Marquee>();
		}
		public function startRolling():void
		{
			this.addEventListener(Event.ENTER_FRAME,onenterframe);	
		}
		public function stopRolling():void
		{
			this.removeEventListener(Event.ENTER_FRAME,onenterframe);
		}
		private function onenterframe(e:Event):void
		{
			for each(var marq:Marquee in marquees)
			{
				marq.update();
			}
		}
		override public function addChild(child:DisplayObject):DisplayObject
		{
			marquees.push(child);
			return super.addChild(child);
		}
	}
}