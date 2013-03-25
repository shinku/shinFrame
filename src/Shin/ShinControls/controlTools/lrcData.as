package Shin.ShinControls.controlTools
{
	public class lrcData
	{
		private var _showTime:String;
		private var _showContent:String;
		private var _time:Number;
		public function lrcData(_st:String,_sc:String)
		{
			this._showContent=_sc;
			this._showTime=_st;
			cacuelateTimeNum();
		}
		public function get showTime():Number
		{
			return this._time;
		}
		public function get lrcContect():String
		{
			return this._showContent;
		}
		private function cacuelateTimeNum():void
		{
			var arr:Array=new Array();
			arr=this._showTime.split(":");
			var timeBr:Number=1;
			var time:Number=0;
			for(var i:int=0;i<arr.length;i++)
			{
				for(var j:int=0;j<arr.length-i-1;j++)
				{
					timeBr*=60;
				}
				time+=timeBr*arr[i];
				timeBr=1;
			}
			_time=time;
			//trace("在"+time+"秒的时候播放字幕___"+this.lrcContect);
		}
	}
}