package Shin.ShinControls
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class mouseOverAndPlayControler
	{
		private var func:Function;
		public function mouseOverAndPlayControler()
		{
		}
		public  function controlMC(mc:MovieClip,callback:Function=null):void
		{
			
			if(mc)
			{
				mc.addEventListener(MouseEvent.MOUSE_OVER,overMC);
				mc.addEventListener(MouseEvent.MOUSE_OUT,outMC);
				mc.addEventListener(MouseEvent.MOUSE_DOWN,clickMC);
				mc.addEventListener(Event.REMOVED_FROM_STAGE,handleRemovedFrameStage);
				if(callback!=null)
				{
					func=callback;
				}
			}
		}
		private function overMC(e:MouseEvent):void
		{
			var mc:MovieClip=e.currentTarget as MovieClip;
			mc.removeEventListener(Event.ENTER_FRAME,onenterframe);
			if(mc.currentFrame!=mc.totalFrames)
			{
				mc.gotoAndPlay(mc.currentFrame);
			}
		}
		private function outMC(e:MouseEvent):void
		{
			var mc:MovieClip=e.currentTarget as MovieClip;
			mc.addEventListener(Event.ENTER_FRAME,onenterframe);
		}
		private function clickMC(e:MouseEvent):void
		{
			//var mc:MovieClip=e.currentTarget as MovieClip;
			//mc.mouseOverAndPlayControler_callback;
			func();
		}
		private function onenterframe(e:Event):void
		{
			var mc:MovieClip=e.target as MovieClip;
			if(mc.currentFrame!=1)
			{
				mc.prevFrame();
			}
			else
			{
				mc.removeEventListener(Event.ENTER_FRAME,onenterframe);
			}
		}
		private function handleRemovedFrameStage(e:Event):void
		{
			var mc:MovieClip=e.target as MovieClip;
			mc.removeEventListener(Event.ENTER_FRAME,onenterframe);
			mc.removeEventListener(MouseEvent.MOUSE_OVER,overMC);
			mc.removeEventListener(MouseEvent.MOUSE_OUT,outMC);
			mc.removeEventListener(MouseEvent.MOUSE_DOWN,clickMC);
			mc.removeEventListener(Event.REMOVED_FROM_STAGE,handleRemovedFrameStage);
		}
	}
}