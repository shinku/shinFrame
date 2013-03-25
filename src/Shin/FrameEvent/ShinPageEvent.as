package Shin.FrameEvent
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class ShinPageEvent extends Event
	{
		public static var CHANGE_PAGE:String="changepage";
		public static var CHANGE_BOARD:String="changeboard";
		public static var CLOSE_BOARD:String="closeboard";
		public var eventID:int=0;
		public static var ShinPageEventer:EventDispatcher=new EventDispatcher();
		public function ShinPageEvent(type:String,eid:int=0)
		{
			this.eventID=eid;
			super(type);
		}
	}
}