/******************************************************************************
 * 			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 * 					Version 2, December 2004
 * 
 * Copyright (C) Jan 26, 2011 - Jay Moretti <jrmoretti@gmail.com>
 * 
 * Everyone is permitted to copy and distribute verbatim or modified
 * copies of this license document, and changing it is allowed as long
 * as the name is changed.
 * 
 *			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *	TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 * 
 *  0. You just DO WHAT THE FUCK YOU WANT TO. 
 *******************************************************************************/
package com.jaymoretti.loading
{
	import flash.net.URLLoader;
	import flash.utils.ByteArray;
	import flash.display.DisplayObject;
	import flash.display.Bitmap;

	import com.jaymoretti.core.events.AssetLoadEvent;
	import com.jaymoretti.loading.types.AssetTypes;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	public class AssetLoader
	{
		/**************
		 * Create singleton instance. 
		 */
		private static var _instance : AssetLoader;
		private var _params : Object;
		private var loader : *;
		private var _content : *;

		public static function get instance () : AssetLoader
		{
			if (!_instance)
				_instance = new AssetLoader();

			return _instance;
		}

		public static function loadAssets (params : Object) : void
		{
			instance.loadAsset(params);
		}

		/*******
		 * Loads any type of objects.
		 * @param params An object containing the following properties.<br/>
		 * 		  Mandatory Parameters:<br/>
		 * 		  url String;<br/>
		 * 		  type String;<br/>
		 * 		  
		 * 		  Optional Parameters:<br/>
		 * 		  onStart Function;<br/>
		 * 		  onProgress Function;<br/>
		 * 		  onComplete Function;<br/>
		 * 		  onCompleteParams Array;<br/>
		 * 		  onError	 Function;<br/>
		 * 		  
		 * @example AssetLoader.loadAsset({url:"http://www.jaymoretti.com/test.jpg", type:AssetTypes.IMAGE, onStart:onStartHandler, onProgress, onProgress:Handler, onComplete:onCompleteHandler, onCompleteParams:[100, 100]});, 
		 * 		  
		 */
		public function loadAsset (params : Object) : void
		{
			if (!params)
				throw new Error("I can't work if you don't tell me what to load");

			if (!params.type)
				throw new Error("I can't work if you don't tell me what are you loading");

			if (!params.url)
				throw new Error("I can't work if you don't tell me what to load");

			_params = params;

			if (params.type == AssetTypes.XML || params.type == AssetTypes.JSON || params.type == AssetTypes.YAML )
			{
				loader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, onAssetLoadComplete);
				loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
				loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
				loader.addEventListener(Event.INIT, onStart);
			}
			else
			{
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onAssetLoadComplete);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
				loader.contentLoaderInfo.addEventListener(Event.INIT, onStart);
			}

			loader.load(new URLRequest(params.url));
		}

		private function onStart (event : Event) : void
		{
			event.currentTarget.removeEventListener(Event.INIT, onStart)
			if (_params.onStart)
			{
				var startCallback : Function = _params.onStart;
				var startEvent : AssetLoadEvent = new AssetLoadEvent(AssetLoadEvent.LOAD_START);
				startCallback(startEvent);
			}
		}

		private function onError (event : IOErrorEvent) : void
		{
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			if (_params.onError)
			{
				var errorCallback : Function = _params.onError;
				var errorEvent : AssetLoadEvent = new AssetLoadEvent(AssetLoadEvent.LOAD_ERROR);
				errorCallback(errorEvent);
			}
			else
			{
				throw new Error("These are not the droids you are looking for.");
			}
		}

		private function onProgress (event : ProgressEvent) : void
		{
			if (_params.onProgress)
			{
				var progressCallback : Function = _params.onProgress;

				var progressEvent : AssetLoadEvent = new AssetLoadEvent(AssetLoadEvent.LOAD_PROGRESS);
				progressEvent.bytesLoaded = event.bytesLoaded;
				progressEvent.bytesTotal = event.bytesTotal;
				progressEvent.percentage = (event.bytesLoaded / event.bytesTotal) * 100;
				progressEvent.roundPercentage = Math.round(progressEvent.percentage);
				progressCallback(progressEvent);
			}
		}

		private function onAssetLoadComplete (event : Event) : void
		{
			event.currentTarget.removeEventListener(Event.COMPLETE, onAssetLoadComplete);
			switch(_params.type)
			{
				case AssetTypes.IMAGE:
					Bitmap(event.currentTarget.content).smoothing = true;
					_content = Bitmap(event.currentTarget.content);
					break;
				case AssetTypes.SWF:
					_content = DisplayObject(event.currentTarget.content);
					break;
				case AssetTypes.BYTES:
					_content = ByteArray(event.currentTarget.content);
					break;
				case AssetTypes.XML:
					XML.ignoreWhitespace = true;
					_content = XML(event.currentTarget.data);
					break;
				case AssetTypes.JSON:
					_content = Object(event.currentTarget.data);
					break;
				case AssetTypes.YAML:
					_content = Object(event.currentTarget.data);
					break;
			}
			onCompleteCallback();
		}

		private function onCompleteCallback () : void
		{
			var event : AssetLoadEvent = new AssetLoadEvent(AssetLoadEvent.LOAD_COMPLETE);
			event.content = _content;

			if (_params.onComplete)
			{
				var completeCallback : Function = _params.onComplete;
				if (_params.onCompleteParams)
					completeCallback(event, _params.onCompleteParams);
				else
					completeCallback(event);
			}
		}
	}
}