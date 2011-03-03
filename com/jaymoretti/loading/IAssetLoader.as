package com.jaymoretti.loading
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	public interface IAssetLoader
	{
		function load(url:String):void;
		function loadComplete(event:Event):void;
		function loadError(event:IOErrorEvent):void;
	}
}