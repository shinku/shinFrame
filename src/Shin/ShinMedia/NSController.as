package Shin.ShinMedia
{
	import Shin.FrameEvent.ShinVideoEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	public class NSController extends EventDispatcher
	{
		private static var VideoIsStatic:int=1;
		private static var VideoDy:int=0;
		private var videoSrc:String="";
		public var nc:NetConnection
		public var ns:NetStream;
		private var _video:Video;
		private var _nsClient:ShinNsClient;
		private var soundtrans:SoundTransform;
		public var isPlay:Boolean=false;
		public var isTraceStatus:Boolean=false;
		public function NSController(video:Video=null,videoIsStatic:int=1)
		{
			this._video=video;
			if(videoIsStatic==NSController.VideoIsStatic)
			{
				nc=ShinMediaData.VideoNC=new NetConnection();
				nc.connect(null);
				ns=ShinMediaData.VideoNS=new NetStream(nc);
			}
			else
			{
				nc=new NetConnection();
				nc.connect(null);
				ns=new NetStream(nc);
			}
			
			_nsClient=new ShinNsClient();
			ns.client=_nsClient;
			ns.addEventListener(NetStatusEvent.NET_STATUS,handleNetStatus);
			soundtrans=new SoundTransform();
			ns.soundTransform=soundtrans;
			if(_video!=null)
			{
				_video.attachNetStream(ns);
			}
		}
		public function set VideoSource(str:String):void
		{
			this.videoSrc=str;
			isPlay=false;
			//trace("set video source="+this.videoSrc)
		}
		public function get VideoSource():String
		{
			return videoSrc
		}
		public function set VideoClient(video:Video):void
		{
			_video=video;
			_video.attachNetStream(ns);
		}
		public function get VideoClient():Video
		{
			return this._video;
		}
		public function playVideo(str:String="",video:Video=null):void
		{
			//trace(videoSrc,_video);
			//trace(">"+this.videoSrc);
			if(str=="" && this.videoSrc!="")
			{
				trace(videoSrc);
				ns.play(videoSrc);
			}
			if(str=="" && this.videoSrc=="")
			{
				return;
			}
			else if(str!="")
			{
				this.videoSrc=str;
				ns.play(str);
				//trace(str)
			}
			if(video!=null)
			{    
				this._video=video;
				_video.attachNetStream(ns);
			}
			isPlay=true;
			//video.attachNetStream(ns);
		}
		private function handleNetStatus(e:NetStatusEvent):void
		{
			if(isTraceStatus)
			{
				trace(e.info.code);
			}
			switch(e.info.code)
			{
				case "NetStream.Play.Start":
					this.dispatchEvent(new ShinVideoEvent(ShinVideoEvent.VIDEO_BEGIN));
					ShinVideoEvent.ShinVideoEventer.dispatchEvent(new ShinVideoEvent(ShinVideoEvent.VIDEO_BEGIN));//发送视频播放结束事件！
						break;
				case "NetStream.Buffer.Empty":
						break;
				case "NetStream.Buffer.Full":
						break;
				case "NetStream.Play.Stop":
						this.dispatchEvent(new ShinVideoEvent(ShinVideoEvent.VIDEO_OVER));
						ShinVideoEvent.ShinVideoEventer.dispatchEvent(new ShinVideoEvent(ShinVideoEvent.VIDEO_OVER));//发送视频播放结束事件！
						break;
				case "NetStream.Play.StreamNotFound":
						trace("未找到视频 videoName="+this.videoSrc);
						break;
			}
		}
		public function pausePlay():void
		{
			ns.pause();
			//trace("[]"+this.videoSrc);
		}
		public function resumePlay():void
		{
			ns.resume();
		}
		public function disposePlay():void
		{
			ns.close();
		}

		public function seekPlay(offset:Number):void
		{
			ns.seek(offset);
		}
		public function changeVolum(value:Number):void
		{
			soundtrans.volume=value;
			ns.soundTransform=soundtrans;
		}
		public function get nsTime():Number
		{
			return ns.time;
		}
		public function get videoLength():Number
		{
			return this._nsClient.videoLength;
		}
		public function get percentLoaded():Number
		{
			var percent:Number=ns.bytesLoaded/ns.bytesTotal;
			return percent;
		}
		public function get percentPlaying():Number
		{
			return this.nsTime/this._nsClient.videoLength;
		}
	}
}