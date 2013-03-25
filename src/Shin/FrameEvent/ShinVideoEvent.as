package Shin.FrameEvent
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class ShinVideoEvent extends Event
	{
		public static var VIDEO_BEGIN:String="videoBegin";
		public static var VIDEO_OVER:String="videoOver";
		public static var VIDEO_PAUSE:String="videoPause";
		public static var ShinVideoEventer:EventDispatcher=new EventDispatcher();
		public function ShinVideoEvent(type:String)
		{
			super(type);
		}
	}
}