package Shin.Container
{
	import Shin.Data.ShinPageData;
	import Shin.FrameEvent.ShinPageEvent;
	import Shin.ShinNet.NAVI;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import mx.messaging.channels.StreamingAMFChannel;
	
	public class ShinSubPageLoader extends Sprite
	{
		
		protected var pageloader:Loader=new Loader();
		protected var pageContext:LoaderContext=new LoaderContext();
		public var _window:String="_self";
		protected var swfMcLab:Object=new Object();
		//private var _isStore:Boolean;
		protected var myMC:MovieClip;
		protected var swfName:String;
		public function ShinSubPageLoader()
		{
			//isStore用于设置是否对所载对象进行保存;
			//如果是swf对象，载入的对象转化成MovieClip之后，对movieclip进行相应事件的监听和移除
			//相应的事件涉及EVENT.ADDED_TO_STAGE,EVENT.REMOVED_FROM_STAGE等相关事件，
			//this._isStore=isStore;
			pageloader.contentLoaderInfo.addEventListener(Event.COMPLETE,handlePageLoaded);
			pageloader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,handleError);
			pageloader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,handlePageLoading);
			ShinPageEvent.ShinPageEventer.addEventListener(ShinPageEvent.CHANGE_PAGE,handleChangePage);
		}
		protected function handleChangePage(e:ShinPageEvent):void
		{
			
			var pageId:int=e.eventID;
			this.ChangePage(pageId);
		}
		protected function ChangePage(pageId:int):void
		{
			var pdata:ShinPageData=ShinPageData.PageLabs[pageId];
			switch(pdata.PageType)
			{
				case ShinPageData.PageType_HTML:
					doHtmlPage(pdata.PageSrc);
					break;
				case ShinPageData.PageType_SWF:
					swfName=pdata.PageSrc;
					if(swfMcLab[swfName])
					{
						if(myMC)
						{
							this.removeChild(myMC);	
						}
						myMC=swfMcLab[swfName] as MovieClip;
						addChildAt(myMC,0)
					
						return;
						
					}
					else
					{
						doSwfPage(pdata.PageSrc);
					}
					break;
				case ShinPageData.PageType_VIDEO:	
					doVideoPage(pdata.PageSrc);
					break;
			}
		}
		protected function doHtmlPage(str:String):void
		{
			Shin.ShinNet.NAVI.navigateTO(str,this._window);
		}
		protected function doSwfPage(str:String):void
		{
			pageloader.unloadAndStop();
			pageloader.load(new URLRequest(str),this.pageContext);
			pageContext.applicationDomain=ApplicationDomain.currentDomain;
		}
		protected function doVideoPage(str:String):void
		{
			
		}
		protected function handlePageLoaded(e:Event):void
		{
			if(myMC)
			{
				this.removeChild(myMC);
			}
			myMC=e.target.content as MovieClip;
			swfMcLab[swfName]=myMC;
			addChildAt(myMC,0)
		}
		protected function handleError(e:IOErrorEvent):void
		{
			trace("somthing is wrong with the network")
		}
		protected function handlePageLoading(e:ProgressEvent):void
		{
			
		}
	}
}