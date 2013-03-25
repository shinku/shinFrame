package Shin.FrameEvent
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	public class ShinDataEvent extends Event
	{
		public static const GET_DATA:String="getdata";
		public static const GET_DATA_ERROR:String="getdataerror";
		public var result:Object;
		public static const DataEventer:EventDispatcher=new EventDispatcher();
		
		public function ShinDataEvent(type:String,str:Object)
		{
			this.result=str;
			super(type);	
		}
	}
}