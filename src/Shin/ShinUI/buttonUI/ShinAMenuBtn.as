package Shin.ShinUI.buttonUI
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;

	public class ShinAMenuBtn extends MovieClip
	{
		private var mygroup:ShinBtngroup;
		//private var _isClicked:Boolean=false;
		//private var _isOver:Boolean=false;
		private var opC:btnOp;
		public function ShinAMenuBtn()
		{
			this.buttonMode=true;
			opC=new btnOp();
			opC.setTargetAndFunction(this,overIt,outIt,clickIt);
			//this.addEventListener(MouseEvent.MOUSE_DOWN,handleClickIt);
			//this.addEventListener(MouseEvent.MOUSE_OVER,handleOverIt);
			//this.addEventListener(MouseEvent.MOUSE_OUT,handleOutIt);
		}
/*		private function handleClickIt(e:MouseEvent):void
		{
			if(!this._isClicked)
			{
				clickIt();
				this.isClicked=true;
			}
		}
		private function handleOverIt(e:MouseEvent):void
		{
			_isOver=true;
			//trace(this.isClicked);
			if(!this._isClicked)
			{
				overIt();
			}
		}
		private function handleOutIt(e:MouseEvent):void
		{
			_isOver=false;
			if(mygroup)
			{
				if(!this._isClicked)
				{	
					outIt();
				}
				else
				{
					return;
				}
			}
			else
			{
				outIt();
				this._isClicked=false;
			}
		}
*/
		public function get isOver():Boolean
		{
			return this.opC._isOver;
		}
		internal function set isClicked(val:Boolean):void
		{
			/*if(opC._isClicked && val==false)
			{
				this.outIt();
				///trace("ouit");
				opC._isClicked=val;
				return;
			}
			opC._isClicked=val;*/
			opC.isClicked=val;
		}
		internal function get isClicked():Boolean
		{
			return opC._isClicked;
		}
		public function clickIt():void
		{
			this.alpha=.3;	
		}
		public function overIt():void
		{
			this.alpha=.6;
		}
		public function outIt():void
		{
			//trace(this.alpha);
			this.alpha=1;
		}
		public function set group(_group:ShinBtngroup):void
		{
			//mygroup=_group;
			//mygroup.push(this);
			this.opC.group=_group;
		}
		public function get group():ShinBtngroup
		{
			return mygroup;
		}
		public function addShape():void
		{
			var sp:Shape=new Shape();
			sp.graphics.beginFill(0xff00ff);
			sp.graphics.drawRect(0,0,50,20);
			sp.graphics.endFill();
			this.addChild(sp);
		}
	}
}