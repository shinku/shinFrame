package Shin.ShinUI.buttonUI
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	public class btnOp extends EventDispatcher
	{
		
		private var mytarget:InteractiveObject;
		
		private var myoverfun:Function;
		private var myoutfun:Function;
		private var myclickfun:Function;
		
		private var myoverpars:*;
		private var myoutpars:*;
		private var myclickpars:*;
		
		
		public var _isClicked:Boolean=false;
		public var _isOver:Boolean=false;
		
		private var mygroup:ShinBtngroup;
		
	
		
		public function btnOp()
		{
			
		}
		public function setTargetAndFunction(target:InteractiveObject,overfun:Function,outfun:Function,clickfun:Function,overfunpars:*=null,outfunpars:*=null,clickfunpars:*=null):void
		{
			
			this.myoverfun=overfun;
			this.myoutfun=outfun;
			this.myclickfun=clickfun;
			mytarget=target;
			target.addEventListener(MouseEvent.MOUSE_OVER,handleover);
			target.addEventListener(MouseEvent.MOUSE_OUT,handleout);
			target.addEventListener(MouseEvent.MOUSE_DOWN,handledown);
			myoverpars=overfunpars;
			myoutpars=outfunpars;
			myclickpars=clickfunpars;
		}
		
		private function handleover(e:MouseEvent):void
		{
			/*if(myoverfun!=null)
			{
				myoverfun();
			}*/
			_isOver=true;
			if(!this._isClicked)
			{
				if(myoverfun!=null)
				{
					if(myoverpars!=null)
					{
						myoverfun(myoverpars);
						//return;
					}
					else
					{
						myoverfun();
					}
				}
			}
		}
		private function handleout(e:MouseEvent):void
		{
			/*if(myoutfun!=null)
			{
				myoutfun();
			}*/
			_isOver=false;
		
			if(mygroup)
			{
				if(!_isClicked)
				{	
					if(myoutfun!=null)
					{
						if(this.myoutpars)
						{
							myoutfun(myoutpars)
						}
						else
						{
							myoutfun();
						}
					}
				}
				else
				{
					return;
				}
			}
			else
			{
				if(myoutfun!=null)
				{
					if(this.myoutpars)
					{
						myoutfun(myoutpars)
					}
					else
					{
						myoutfun();
					}
				}
				this._isClicked=false;
			}
		}
		private function handledown(e:MouseEvent):void
		{
			
			if(myclickfun!=null)
			{
				this._isClicked=true;
				if(this.myclickpars)
				{
					myclickfun(myclickpars);
				}
				else
				{
					myclickfun();
				}
			}
			this.dispatchEvent(new Event("SELECTED"));
		}
		public function removeTarget():void
		{
			mytarget.removeEventListener(MouseEvent.MOUSE_OVER,handleover);
			mytarget.removeEventListener(MouseEvent.MOUSE_OUT,handleout);
			mytarget.removeEventListener(MouseEvent.MOUSE_DOWN,handledown);
		}
		public function set group(_group:ShinBtngroup):void
		{
			mygroup=_group;
			
			_group.push(this);
		}
		public function set isClicked(val:Boolean):void
		{
			if(_isClicked && val==false)
			{
				if(this.myoutfun!=null)
				{
					if(this.myoutpars)
					{
						myoutfun(myoutpars)
					}
					else
					{
						myoutfun();
					}
				}
				_isClicked=val;
				return;
			}
			_isClicked=val;
		}
		public function get isClicked():Boolean
		{
			return this._isClicked;
		}
	}
}