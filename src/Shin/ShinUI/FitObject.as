package Shin.ShinUI
{
	import Shin.Interfaces.IFit;
	import Shin.UIManager.UIManagerBasedOnStage;
	
	import flash.display.MovieClip;
	import flash.events.Event;

	public class FitObject extends MovieClip implements IFit
	{
		public function FitObject()
		{
			if(stage==null)
			{
				this.addEventListener(Event.ADDED_TO_STAGE,handleAdded);
			}
			else
			{
				init();
				setInit();
			}
		}
		//interfaces function
		public function setInit():void
		{
			UIManagerBasedOnStage.uiPool.push(this);
			if(UIManagerBasedOnStage.instance==null)
			{
				UIManagerBasedOnStage.instance=new UIManagerBasedOnStage(stage);
			}
			else
			{
				return;
			}
		}
		public function updatePosition():void
		{
			this.setPos();
		}
		public function get echoToUpdate():Boolean
		{
			return this.visible
		}
		public function get fitName():String
		{
			return this.name;
		}
		//interfaces function end
		protected function init():void
		{
			setPos();
			this.addEventListener(Event.REMOVED_FROM_STAGE,handleRemoved);
		}
		private function handleAdded(e:Event):void
		{
			removeAddEvent();
			//this.removeEventListener(Event.ADDED_TO_STAGE,handleAdded);
			init();
			setInit();
		}
		protected function removeAddEvent():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,handleAdded);
		}
		private function handleRemoved(e:Event):void
		{
			beremoved();
		}
		protected function setPos():void
		{
			this.x=(stage.stageWidth-this.width)/2	;
			this.y=(stage.stageHeight-this.height)/2;
		}
		protected function beremoved():void
		{
			UIManagerBasedOnStage.spliceUI(this);
		}
	}
}