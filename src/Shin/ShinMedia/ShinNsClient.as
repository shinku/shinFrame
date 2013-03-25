package Shin.ShinMedia
{
	import Shin.FrameEvent.ShinVideoEvent;
	public class ShinNsClient
	{
		private var _videoWidth:Number;
		private var _videoHeight:Number;
		private var _videoLength:Number;
		private var _frameRate:Number;
		private var isGetOBJ:Boolean=false;
		public function ShinNsClient()
		{
			
		}
		public function onMetaData(obj:Object):void
		{
			//this.isGetOBJ=true
			this._videoWidth=obj.width;
			this._videoHeight=obj.height;
			this._videoLength=obj.duration;
			this._frameRate=obj.framerate;
			if(!this.isGetOBJ)
			{
				ShinVideoEvent.ShinVideoEventer.dispatchEvent(new ShinVideoEvent(ShinVideoEvent.VIDEO_BEGIN));
				this.isGetOBJ=true;
			}
		}
		public function onPlayStatus(obj:Object):void
		{
			
		}
		public function onXMPData(obj:Object):void
		{
			
		}
		public function get videoWidth():Number
		{
			return this._videoWidth;
		}
		public function get videoHeight():Number
		{
			return this._videoHeight;
		}
		public function get videoLength():Number
		{
			return this._videoLength;
		}
		public function get videoFrameRate():Number
		{
			return this._frameRate;
		}
	}
}