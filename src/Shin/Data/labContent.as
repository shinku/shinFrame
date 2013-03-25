package Shin.Data
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;

	public class labContent extends EventDispatcher
	{
		private var loader:Loader=new Loader();
		public var disID:String;
		public var content:*;
		public function labContent()
		{
			
		}
		public function load(src:String):void
		{
			this.disID=src;
			loader.addEventListener(Event.COMPLETE,handleLoaded);
			loader.load(new URLRequest(src));
		}
		private function handleLoaded(e:Event):void
		{
			content=e.target.content;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
	}
} 