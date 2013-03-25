package Shin.FrameEvent
{
	import flash.events.Event;

	public class ShinEvent extends Event
	{
		public static const SHIN_COMPLETE:String="shincomplete";
		public function ShinEvent(type:String)
		{
			super(type);
		}
	}
}