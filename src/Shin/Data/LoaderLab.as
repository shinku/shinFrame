package Shin.Data
{
	import Shin.FrameEvent.ShinEvent;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;

	public class LoaderLab extends EventDispatcher
	{	
		private var loader:labContent;
		private static const lab:Object=new Object();
		public function LoaderLab()
		{
			loader=new labContent();
			loader.addEventListener(Event.COMPLETE,handleLoaded);
		}
		public function loadContent(src:String):void
		{
			if(!lab[src])
			{
				loader.load(src);
			}
			else
			{
				this.dispatchEvent(new ShinEvent(ShinEvent.SHIN_COMPLETE));	
			}
		}
		private function handleLoaded(e:Event):void
		{
			lab[loader.disID]=loader.content;
			this.dispatchEvent(new ShinEvent(ShinEvent.SHIN_COMPLETE));
		}
		public function get data():*
		{
			return loader.content;
		}
	}
}