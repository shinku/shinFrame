package Shin.FrameEvent
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class ShinUserEvent extends Event
	{
		public static var USER_LOGGED_SUSSESSED:String="userloggedsuccessed";//用户登录成功事件
		public static var USER_CANCELED:String="usercanceled";//用户注销事件
		//public static var USER_GET_NET_DATA:String
		public static var ShinUserEventer:EventDispatcher=new EventDispatcher();
		public function ShinUserEvent(type:String)
		{
			super(type);	
		}
	}
}