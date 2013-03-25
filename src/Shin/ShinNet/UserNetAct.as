package Shin.ShinNet
{
	import Shin.FrameEvent.ShinDataEvent;
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;

	public class UserNetAct extends EventDispatcher                   //just like poxy!!!!
	{
		public static const STRINGdataAnalysisformat:String="string";
		public static const XMLdataAnalysisformat:String="xml";
		public static const JSONdataAnalysisformat:String="json";
		private static var _instance:UserNetAct;
		public var dataAnalysisFormat:String;
		private var urlloader:URLLoader=new URLLoader();
		private var vai:URLVariables=new URLVariables();
		private var request:URLRequest=new URLRequest();
		private var isUseSelfEventDispatcher:Boolean=false;
		public function UserNetAct(_dataAnalysisFormat:String="string",_isUseSelfEventDispatcher:Boolean=false)
		{
			this.dataAnalysisFormat=_dataAnalysisFormat;
			urlloader.addEventListener(Event.COMPLETE,handleDataGeted);
			urlloader.addEventListener(IOErrorEvent.IO_ERROR,handleIoerror);
			urlloader.addEventListener(ProgressEvent.PROGRESS,handleSendingData);
			this.isUseSelfEventDispatcher=_isUseSelfEventDispatcher;
		}
		public static function getInstance(_dataAnalysisFormat:String="string",_isUseSelfEventDispatcher:Boolean=false):UserNetAct
		{
			if(!_instance)
			{
				_instance=new UserNetAct(_dataAnalysisFormat,_isUseSelfEventDispatcher);
			}
			_instance.dataAnalysisFormat=_dataAnalysisFormat;
			return _instance;
		}
		public  function sendMessToService(idata:Object,url:String):void
		{
			
			request.url=url;
			for(var par:* in idata)
			{
				vai[par]=idata[par];
			}
			request.data=vai;
			request.method="post";
			//urlloader.dataFormat=URLLoaderDataFormat.BINARY;
			//urlloader.dataFormat=URLLoaderDataFormat.
			//trace("BINARY");
			urlloader.load(request);
			urlloader.addEventListener(Event.COMPLETE,handleDataGeted);
			urlloader.addEventListener(IOErrorEvent.IO_ERROR,handleIoerror);
			urlloader.addEventListener(ProgressEvent.PROGRESS,handleSendingData);
		}
		public function sendBinaryToService(url:String,data:ByteArray):void//用于上传2进制流至服务器
		{
			request.url=url;
			request.data=data;
			request.contentType="application/octet-stream";
			request.method=URLRequestMethod.POST;
			urlloader.dataFormat=URLLoaderDataFormat.BINARY;
			urlloader.load(request);
			//trace(data);
			urlloader.addEventListener(Event.COMPLETE,handleDataGeted);
			urlloader.addEventListener(IOErrorEvent.IO_ERROR,handleIoerror);
			urlloader.addEventListener(ProgressEvent.PROGRESS,handleSendingData);
		}
		private function handleDataGeted(e:Event):void
		{
			//trace("REUSDLT="+e.target.data);
			var _result:String=e.target.data;
			if(!_result)
			{
				return;
				
			}
			//trace(_result);
			//var event:ShinDataEvent=new ShinDataEvent(ShinDataEvent.GET_DATA,_result);
			var _resultToSended:Object;
			switch(this.dataAnalysisFormat)
			{
				case STRINGdataAnalysisformat:_resultToSended=_result;break;
				case XMLdataAnalysisformat:
					_resultToSended=XML(_result);
					break;
				case JSONdataAnalysisformat:
					_resultToSended=com.adobe.serialization.json.JSON.decode(_result);
					break;
			}
			ShinDataEvent.DataEventer.dispatchEvent(new ShinDataEvent(ShinDataEvent.GET_DATA,_resultToSended));
			if(this.isUseSelfEventDispatcher)
			{
				this.dispatchEvent(new ShinDataEvent(ShinDataEvent.GET_DATA,_resultToSended));
			}
			urlloader.removeEventListener(Event.COMPLETE,handleDataGeted);
			urlloader.removeEventListener(IOErrorEvent.IO_ERROR,handleIoerror);
			urlloader.removeEventListener(ProgressEvent.PROGRESS,handleSendingData);
		}
		private function handleIoerror(e:IOErrorEvent):void
		{
			urlloader.removeEventListener(Event.COMPLETE,handleDataGeted);
			urlloader.removeEventListener(IOErrorEvent.IO_ERROR,handleIoerror);
			urlloader.removeEventListener(ProgressEvent.PROGRESS,handleSendingData);
			ShinDataEvent.DataEventer.dispatchEvent(new ShinDataEvent(ShinDataEvent.GET_DATA_ERROR,"ERROR"));
			if(this.isUseSelfEventDispatcher)
			{
				//
				this.dispatchEvent(new ShinDataEvent(ShinDataEvent.GET_DATA_ERROR,"ERROR"));
			}
			trace("somthing is wrong with the network when i am sending some data to the network!!");
			
		}
		private function handleSendingData(e:ProgressEvent):void
		{
		
		}
	}
}