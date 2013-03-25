package Shin.ShinUI.buttonUI
{
	import flash.events.Event;

	public class ShinBtngroup
	{
		private var btns:Vector.<btnOp>;
		private var _groupName:String;
		public function ShinBtngroup(_name:String="")
		{
			_groupName=_name;
			btns=new Vector.<btnOp>();
		}
		public function push(btn:btnOp):void
		{
			btns.push(btn);
			btn.addEventListener("SELECTED",clickBtn);
		}
		private function clickBtn(e:Event):void
		{
			
			var btn:btnOp=e.target as btnOp;
			for(var i:int=0;i<btns.length;i++)
			{
				if(btn==btns[i])
				{
					btn.isClicked=true;
				}
				else
				{
					btns[i].isClicked=false;
				}
			}
		}
		
		public function get groupName():String
		{
			return this._groupName;
		}
		public function reSet():void
		{
			btns=new Vector.<btnOp>();
		}
	}
}