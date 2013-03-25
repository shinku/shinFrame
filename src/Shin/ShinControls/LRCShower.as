package Shin.ShinControls
{
	import Shin.ShinControls.controlTools.LRCDataProvider;
	import Shin.ShinMedia.NSController;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.NetStream;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class LRCShower extends Sprite
	{
		private var lrcdataProvider:LRCDataProvider;
		private var nsControled:NSController;
		private var _ns:NetStream;
		private var subtitleTxt:TextField=new TextField();
		private var txtFormat:TextFormat=new TextFormat("arial","20",0xffffff,true);
		private var posCenterX:Number=0;
		public function LRCShower(cx:Number=0,txtWidth:Number=300,txtFt:TextFormat=null)
		{
			addChild(subtitleTxt);
			this.posCenterX=cx;
			if(txtFt!=null)
			{
				txtFormat=txtFt;
			}
			subtitleTxt.width=txtWidth;
			subtitleTxt.autoSize=TextFieldAutoSize.LEFT;
			//subtitleTxt.border=true;
			subtitleTxt.multiline=true;
			subtitleTxt.wordWrap=true;
			subtitleTxt.defaultTextFormat=txtFormat;
			this.addEventListener(Event.REMOVED_FROM_STAGE,handleRemoveThis);
		}
		public function set centerX(cx:Number):void
		{
			this.posCenterX=cx;
		}
		public function set subTitleWidth(_w:Number):void
		{
			this.subtitleTxt.width=_w;
		}
		public function setTextFormat(txtFt:TextFormat):void
		{
			this.txtFormat=txtFt;
			subtitleTxt.setTextFormat(this.txtFormat);
		}
		public function set dataProvider(data:LRCDataProvider):void
		{
			this.lrcdataProvider=data;
		}
		public function set nsClient(ns:NetStream):void
		{
			this._ns=ns;
			_ns.addEventListener(NetStatusEvent.NET_STATUS,handleNsStatus);
			this.addEventListener(Event.ENTER_FRAME,onenterframe);
		}
		private function handleNsStatus(e:NetStatusEvent):void
		{
			switch(e.info.code)
			{
				case "NetStream.Play.Start":
					this.addEventListener(Event.ENTER_FRAME,onenterframe);
					break;
				case "NetStream.Buffer.Empty":
					break;
				case "NetStream.Buffer.Full":
					break;
				case "NetStream.Play.Stop":
					this.removeEventListener(Event.ENTER_FRAME,onenterframe);
					//ShinVideoEvent.ShinVideoEventer.dispatchEvent(new ShinVideoEvent(ShinVideoEvent.VIDEO_OVER));//发送视频播放结束事件！
					break;
			}
		}
		private function onenterframe(e:Event):void
		{
			this.lrcdataProvider.getSubtitle(_ns.time,this.subtitleTxt);
			subtitleTxt.x=this.posCenterX-subtitleTxt.textWidth/2;
		}
		private function handleRemoveThis(e:Event):void
		{
			if(_ns)
			{
				_ns.removeEventListener(NetStatusEvent.NET_STATUS,handleNsStatus);
			}
			this.removeEventListener(Event.ENTER_FRAME,onenterframe);
		}
	}
}