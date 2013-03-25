package Shin.Container
{
	import Shin.ShinUI.FitObject;
	import Shin.ShinUI.ShinAboard;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	public class ShinBoardContainer extends FitObject
	{
		protected var boardLoader:Loader=new Loader();
		private var boardContent:LoaderContext=new LoaderContext();
		protected var _board:ShinAboard=null;
		protected var applicationdomain:ApplicationDomain;
		private var isMCLoaded:Boolean=false;
		private var readyAddBoardId:int=-1;
		public function ShinBoardContainer(mcStr:String="")
		{
			if(mcStr!="")
			{
				boardLoader.load(new URLRequest(mcStr),boardContent);
				boardLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,handleBoardLoaded);
				boardLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,handleError);
				boardLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,handleMCLoading);
			}
		}
		protected function handleBoardLoaded(e:Event):void
		{
			//
			trace("Symbols have loaded!!")
			boardLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,handleBoardLoaded);
			boardLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,handleError);
			boardLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,handleMCLoading);
			//注销侦听的事件
			boardContent.applicationDomain=ApplicationDomain.currentDomain;
			applicationdomain=boardLoader.contentLoaderInfo.applicationDomain;
			this.isMCLoaded=true;
			if(this.readyAddBoardId!=-1)
			{
				addBoardByID(this.readyAddBoardId);
			}
		}
		private function handleError(e:IOErrorEvent):void
		{
			trace("Somthing is wrong with the net work!!Can't load the Symbols");
		}
		protected function handleMCLoading(e:ProgressEvent):void
		{
			
		}
		override protected function setPos():void
		{
			if(this._board!=null)
			{
				_board.x=(stage.stageWidth-_board.width)/2;
				_board.y=(stage.stageHeight-_board.height)/2;
			}
		}
		public function addBoardByID(boardID:int):void
		{
			//this.
			if(this.isMCLoaded==false)
			{
				//this.isMCLoaded
				this.readyAddBoardId=boardID;
				return;
			}
			else
			{
				var _boardClass:Class=getBoardClass(boardID);
				if(_boardClass!=null)
				{
					//trace(_boardClass);
					_board=new _boardClass();
					//trace(_board);
					addBoard();
				}
				else
				{
					removeBoard();
				}
			}
		}
		protected function addBoard():void
		{
			//removeBoard();
			//trace(_board);
			addChild(_board);
			setPos();
		}
		protected function removeBoard():void
		{
		
			if(_board!=null)
			{
				removeChild(_board);
				_board=null;
			}
		}
		protected function getBoardClass(id:int):Class
		{
			return null;
			//get the class here，override function by this children class;
		}
	}
}