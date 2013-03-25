package Shin.ShinControls.ControlInterface
{
	import Shin.ShinControls.ShinPlayBtn;
	import Shin.ShinMedia.NSController;
	import Shin.ShinControls.ControlInterface.PauseState

	public class PlayState implements IPlayState
	{
		private var nsc:NSController;
		private var btn:ShinPlayBtn;
		public function PlayState(_btn:ShinPlayBtn)
		{
			//this.nsc=ns;
			this.btn=_btn;
			btn.playStateDiscribe=ShinPlayBtn.PLAYING;
			//this.btn=ShinPlayBtn;
		}
		public function setNextState():void
		{
			btn.playState=new PauseState(btn);
			
		}
		public function doState(ns:NSController):void
		{
				//ns
			if(ns.isPlay)
			{
				ns.resumePlay();
			}
			else
			{
				ns.playVideo();
			}
			btn.changeToPlayStateUE();
		}
	}
}