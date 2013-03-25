package Shin.Data
{
	public class ShinPageData
	{
		public static var PageType_SWF:String="swf";
		public static var PageType_HTML:String="html";
		public static var PageType_VIDEO:String="video";
		public static var PageLabs:Vector.<ShinPageData>;
		public var PageSrc:String;
		public var PageType:String;
		public function ShinPageData(type:String,src:String)
		{
			this.PageSrc=src;
			this.PageType=type;
		}
	}
}