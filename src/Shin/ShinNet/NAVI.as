package Shin.ShinNet
{
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	public class NAVI
	{
		public function NAVI()
		{
		}
		public static function navigateTO(url:String,window:String="_blank"):void
		{
			var request:URLRequest = new URLRequest(url);
			if (!ExternalInterface.available) {
				navigateToURL(request, window);
			} else {
				try {					
					var strUserAgent:String = String(ExternalInterface.call("function() {return navigator.userAgent;}")).toLowerCase();
					if (strUserAgent.indexOf("firefox") != -1 ||
						(strUserAgent.indexOf("msie") != -1 && uint(strUserAgent.substr(strUserAgent.indexOf("msie") + 5, 3)) >= 7)) {
						ExternalInterface.call("window.open", request.url, window);
					} else {
						navigateToURL(request, window);
					}
				} catch(e:Error) {
					navigateToURL(request, window);
				}
			}	
		}
	}
}