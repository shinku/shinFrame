package Shin.ShinControls.ControlInterface
{
	import Shin.ShinMedia.NSController;

	public interface IPlayState
	{
		function setNextState():void;
		function doState(ns:NSController):void;
	}
}