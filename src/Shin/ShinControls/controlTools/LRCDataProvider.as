package Shin.ShinControls.controlTools
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.text.TextField;

	public class LRCDataProvider
	{
		private var lrcDatas:Vector.<lrcData>=new Vector.<lrcData>();
		private var _lrcURL:String;
		private var _lrcLoader:URLLoader=new URLLoader();
		private var _lrcGet:String;
		public function LRCDataProvider(lrcUrl:String)
		{
			this._lrcURL=lrcUrl;
			_lrcLoader.dataFormat=URLLoaderDataFormat.TEXT;
			_lrcLoader.load(new URLRequest(lrcUrl));
			_lrcLoader.addEventListener(Event.COMPLETE,handleLrcLoaded);
			_lrcLoader.addEventListener(IOErrorEvent.IO_ERROR,handleIoerror);
			//setLrc();
		}
		private function setLrc(lrc:String):void
		{
			
			var lrcStr:String=lrc;
			while(lrcStr.indexOf("[")>=0 && lrcStr.indexOf("]")>=0)
			{
				
				var indexF:int=lrcStr.indexOf("[");
				var indexE:int=lrcStr.indexOf("]");
				var timeDis:String=lrcStr.substring(indexF+1,indexE);
				lrcStr=lrcStr.substr(indexE+1);
				indexF=lrcStr.indexOf("[");
				if(indexF>=0)
				{
					var content:String=lrcStr.substr(0,indexF);
				}
				else
				{
					content=lrcStr.substr(0);
				}
				var lrcdata:lrcData=new lrcData(timeDis,content);
				lrcDatas.push(lrcdata);
			}
		}
		public function loadLrc(str:String):void
		{
			this._lrcURL=str;
			_lrcLoader.load(new URLRequest(_lrcURL));
			_lrcLoader.addEventListener(Event.COMPLETE,handleLrcLoaded);
			_lrcLoader.addEventListener(IOErrorEvent.IO_ERROR,handleIoerror);
		}
		private function handleLrcLoaded(e:Event):void
		{
			setLrc(String(e.target.data));
			_lrcLoader.removeEventListener(Event.COMPLETE,handleLrcLoaded);
			_lrcLoader.removeEventListener(IOErrorEvent.IO_ERROR,handleIoerror);
		}
		private function handleIoerror(e:IOErrorEvent):void
		{
			trace("LRC地址不可用   (X 。 X!)");
		}
		public function getSubtitle(timeIndex:Number,txt:TextField):void
		{
			for(var i:int=0;i<lrcDatas.length;i++)
			{
				if(timeIndex>lrcDatas[i].showTime)
				{
					if(i+1<lrcDatas.length)
					{
						if(timeIndex<lrcDatas[i+1].showTime)
						{
							txt.text=lrcDatas[i].lrcContect;
						}
					}
					else
					{
						txt.text=lrcDatas[i].lrcContect;
					}
				}
			}
		}
	}
}
/*
	lrc 格式参照
	[1:10]lrclrclrclrclrclrclrclrclrclrclrclrclrclrclrclrc
	[1:10]lrclrclrclrclrclrclrclrclrclrclrclrclrclrclrclrc
*/