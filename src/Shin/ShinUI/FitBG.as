package Shin.ShinUI
{
	public class FitBG extends FitObject
	{
		protected var initW:Number;
		protected var initH:Number; 
		public function FitBG(iw:Number=1260,ih:Number=700)
		{
			this.initH=ih;
			this.initW=iw;
			trace("WH"+initW,initH);
			super();
			
		}
		override protected function setPos():void
		{
			var sc:Number;
			var stageSC:Number=stage.stageWidth/stage.stageHeight;
			if(stageSC>initW/initH)
			{
				sc=stage.stageWidth/initW;
			}
			else
			{
				sc=stage.stageHeight/initH;
			}
			this.scaleX=this.scaleY=sc;
			this.x=(stage.stageWidth-this.initW*sc)/2;
			this.y=(stage.stageHeight-this.initH*sc)/2;
		}
	}
}