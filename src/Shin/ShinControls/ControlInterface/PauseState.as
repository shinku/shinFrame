package Shin.ShinControls.ControlInterface
{
	import Shin.ShinControls.ShinPlayBtn;
	import Shin.ShinMedia.NSController;
	public class PauseState implements IPlayState
	{
	
		private var nsc:NSController;
		private var btn:ShinPlayBtn;
		public function PauseState(_btn:ShinPlayBtn)
		{
			this.btn=_btn;
			//this.nsc=ns;
			btn.playStateDiscribe=ShinPlayBtn.PAUSE;
			//this.btn=ShinPlayBtn;
		}
		public function setNextState():void
		{
			btn.playState=new PlayState(btn);
		}
		public function doState(ns:NSController):void
		{
			//ns
			ns.pausePlay();
		//	trace(ns);
			btn.changeToPauseStateUE();
		}
	}
}