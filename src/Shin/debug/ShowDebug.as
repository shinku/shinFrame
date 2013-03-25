package Shin.debug
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	import Shin.ShinVersion;

	public class ShowDebug
	{
		public static var debugPalne:ShowDebug;
		private var txt:TextField;
		private var _stage:Stage;
		private var version:String=ShinVersion.VERSION;
		private var preTime:Number;
		private var frameCount:int=0;
		private var fps:Number;
		public  function ShowDebug(con:DisplayObjectContainer)
		{
			var sp:Sprite=new Sprite();
			sp.addEventListener(Event.REMOVED_FROM_STAGE,handleSpRemovedFromStage);
			sp.graphics.beginFill(Math.random()*0xffffff,.6);
			sp.graphics.drawRect(0,0,200,100);
			sp.graphics.endFill();
			txt=new TextField();
			sp.addChild(txt);
			txt.width=290;
			txt.multiline=true;
			txt.autoSize="left";
			txt.wordWrap=true;
			con.addChild(sp);
			var tf:TextFormat=new TextFormat();
			tf.size=10;
			tf.font="arial";
			txt.defaultTextFormat=tf;
			txt.selectable=false
			if(!(con is Stage))
			{
				_stage=con.stage;
			}
			else
			{
				this._stage=con as Stage;
			}
			preTime=getTimer();
			//trace(preTime)
			fps=_stage.frameRate;
			sp.addEventListener(Event.ENTER_FRAME,handleEnterframe);
		}
		private function handleSpRemovedFromStage(e:Event):void
		{
			_stage.addEventListener(Event.ENTER_FRAME,handleEnterframe);	
		}
		private function handleEnterframe(e:Event):void
		{
			//var rate:Number=_stage.frameRate;
			var rate:Number=getFps();
			var mem:Number=flash.system.System.totalMemory;
			txt.htmlText="<font color='#ff0000'>FPS: </font>"+"<font color='#000'>"+rate+"_F/S</font><br><font color='#000' family='arial'>MEMORY: "+mem+"</font><br>version: "+version;
		}
		public static function show(obj:DisplayObjectContainer):void
		{
			//trace(123)
			if(ShowDebug.debugPalne==null)
			{
				ShowDebug.debugPalne=new ShowDebug(obj);
			}
		}
		private function getFps():Number
		{
			var ct:Number=getTimer()-preTime;
			frameCount++;
			//trace(frameCount);
			if(Math.round(ct)>=1000)
			{
				fps=frameCount;
				preTime=getTimer();
				frameCount=0;
			}
			return fps;
		}
	}
}