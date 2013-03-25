package Shin.ShinControls
{
	import Shin.ShinControls.ControlInterface.IPlayState;
	import Shin.ShinControls.ControlInterface.PauseState;
	import Shin.ShinControls.ControlInterface.PlayState;
	import Shin.ShinMedia.NSController;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class ShinPlayBtn extends MovieClip
	{
		public var playStateDiscribe:String;
		public static var PLAYING:String="playing";
		public static var PAUSE:String="pause";
		public var playState:IPlayState;
		private var nsC:NSController;
		private var isPlayed:Boolean=false;
		public function ShinPlayBtn()
		{
			this.buttonMode=true;
			this.playStateDiscribe=ShinPlayBtn.PAUSE;
			//this.playState=new Pl
			this.addEventListener(MouseEvent.MOUSE_DOWN,clickIt);
		}
		public function changeToPlayState():void
		{
			this.playState=new PlayState(this);
			//this.changeToPlayStateUE();
			if(nsC)
			{
				playState.doState(nsC);
			}
			playState.setNextState()
		}
		public function changeToPauseState():void
		{
			this.playState=new PauseState(this);
			
			//this.changeToPauseStateUE();
			if(nsC)
			{
				playState.doState(nsC);
			}
			playState.setNextState()
		}
		protected function clickIt(e:MouseEvent):void
		{
			this.clickPlayBtn();
			//trace("clickedIDD")
		}
		public function set nsControler(nsc:NSController):void
		{
			this.nsC=nsc;
			//this.playState=new PauseState(this);
			//clickPlayBtn();
		}
		public function get nsControler():NSController
		{
			return this.nsC;
		}
		public function clickPlayBtn():void
		{
			//trace(playState)
			if(playState)
			{
				if(nsC)
				{
					playState.doState(nsC);
				}
				playState.setNextState();//切换状态！！
			}
		}
		public function set InitPlayState(statedis:String):void
		{
			
				switch(statedis)
				{
					case ShinPlayBtn.PAUSE:this.playState=new PauseState(this);
										this.changeToPauseStateUE();
										playState.setNextState();
										if(this.nsC!=null)
										{
											nsC.pausePlay();
										}
										break;
					case ShinPlayBtn.PLAYING:this.playState=new PlayState(this);
										this.changeToPlayStateUE();
										playState.setNextState();
										if(this.nsC!=null)
										{
											nsC.playVideo();
										}
										break;
					default:break;
				}
			
		}
		public function changeToPlayStateUE():void
		{
			//做一些改变UI的举动
			//this.playState=new PlayState(this);
			//this.changeToPlayStateUE();
		}
		public function changeToPauseStateUE():void
		{
			//this.playState=new PauseState(this);
			//playState.setNextState();
		}
	}
}