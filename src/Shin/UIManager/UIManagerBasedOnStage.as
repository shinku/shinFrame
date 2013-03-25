package Shin.UIManager
{
	import Shin.Interfaces.IFit;
	import Shin.MEManager.MEGC;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.external.ExternalInterface;

	public class UIManagerBasedOnStage
	{
		public static var uiPool:Vector.<IFit>=new Vector.<IFit>();
		public static var instance:UIManagerBasedOnStage=null;
		private var _stage:Stage
		public function UIManagerBasedOnStage($stage:Stage):void
		{
			_stage=$stage;
			_stage.addEventListener(Event.RESIZE,handleResize);
		}
		
		private function handleResize(e:Event):void
		{
			var vec:Vector.<IFit>=UIManagerBasedOnStage.uiPool;
			if(ExternalInterface.available)
			{
				//trace("resizeflash")
				try
				{
					//ExternalInterface.call("resizeFlash");
				}
				catch(e:*)
				{
					trace("somthing wrong ");
				}
			}
			for(var i:int=0;i<vec.length;i++)
			{
				if(vec[i].echoToUpdate)
				{
					vec[i].updatePosition();
				}
			}
		}
		
		//static function\\
		public static function spliceUI(iui:IFit):void
		{
			var vec:Vector.<IFit>=UIManagerBasedOnStage.uiPool;
			for(var i:int=0;i<vec.length;i++)
			{
				if(vec[i]==iui)
				{
					var ui:IFit=vec[i];
					vec.splice(i,1);
					ui=null;
					MEGC.doGC();
					//清理内存用!!
					//break;
					return;
				}
			}
		}
	}
}