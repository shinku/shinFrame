package Shin.Interfaces
{
	import Shin.UIManager.UIManagerBasedOnStage;

	public interface IFit
	{
		function get echoToUpdate():Boolean;
		function setInit():void;
		function updatePosition():void;
		function get fitName():String;
	}
}