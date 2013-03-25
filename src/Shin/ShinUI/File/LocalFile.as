package Shin.ShinUI.File
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	public class LocalFile
	{
		private static var fileStr:String="";
		public function LocalFile()
		{
		}
		public static function loadLocalFile(fileLoader:Loader,filters:Array=null):void
		{
			var file:FileReference=new FileReference();
			if(filters==null)
			{
				filters=[new FileFilter(".jpg","*.jpg"),new FileFilter(".png","*.png"),new FileFilter(".bmp","*.bmp")];
			}
			file.browse(filters);
			file.addEventListener(Event.SELECT,handleSelectedFile);
			file.addEventListener(Event.COMPLETE,handleDataLoaded);
			fileLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,handleFileLoaded);
			function handleSelectedFile(e:Event):void
			{
				LocalFile.fileStr=file.name;
				file.load();
			}
			function handleDataLoaded(e:Event):void
			{
				fileLoader.unloadAndStop();
				fileLoader.loadBytes(file.data);
			}
			function handleFileLoaded(e:Event):void
			{
				file.removeEventListener(Event.SELECT,handleSelectedFile);
				file.removeEventListener(Event.COMPLETE,handleDataLoaded);
				fileLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,handleFileLoaded);
				file=null;
				filters=null;
			}
		}
		public static function getFileName():String
		{
			return LocalFile.fileStr;
		}
	}
}