package Shin.MEManager
{
	import flash.net.LocalConnection;

	public class MEGC
	{
		public function MEGC()
		{
		}
		public static function doGC():void
		{
			var loc1:LocalConnection=new LocalConnection();
			var loc2:LocalConnection=new LocalConnection();
			try
			{
				loc1.connect("SHIN_FRAME_LOCALCONNECTION_VERSION");
				loc2.connect("SHIN_FRAME_LOCALCONNECTION_VERSION");
				
			}
			catch(e:Error)
			{
				//trace("localconetion wrong")
				loc1=null;
				loc2=null;
			}
		}
	}
}