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
	import com.jaymoretti.events.AssetLoadEvent;
	import com.jaymoretti.loading.types.AssetTypes;

	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	public class AssetLoader
	{
		/**************
		 * Create singleton instance. 
		 */
		private static var _instance : AssetLoader;
		private var _params : Object;
		private var loader : *;
		private var _content : *;
		private var _id : String;
		private var _loaded : Boolean;

		public static function get instance() : AssetLoader
		{
			if (!_instance)
				_instance = new AssetLoader();

			return _instance;
		}

		public static function loadAsset(params : Object, id : String = "") : void
		{
			instance.loadAsset(params, id);
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
		public function loadAsset(params : Object, id : String = "") : void
		{
			if (!params)
				throw new Error("I can't work if you don't tell me what to load");

			if (!params.type)
				throw new Error("I can't work if you don't tell me what are you loading");

			if (!params.url)
				throw new Error("I can't work if you don't tell me what to load");

			_params = params;
			_id = id;

			if (params.type == AssetTypes.XML || params.type == AssetTypes.JSON || params.type == AssetTypes.YAML )
			{
				loader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, onComplete, 0, false, 0);
				loader.addEventListener(ProgressEvent.PROGRESS, onProgress, 0, false, 0);
				loader.addEventListener(IOErrorEvent.IO_ERROR, onError, 0, false, 0);
				loader.addEventListener(Event.INIT, onStart, 0, false, 0);
			}
			else
			{
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete, 0, false, 0);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress, 0, false, 0);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError, 0, false, 0);
				loader.contentLoaderInfo.addEventListener(Event.INIT, onStart, 0, false, 0);
			}
			
			_loaded = false; // workaround line... yes, I'm ashamed :p
			loader.load(new URLRequest(params.url));
		}

		private function onStart(event : Event) : void
		{
			event.currentTarget.removeEventListener(Event.INIT, onStart);

			if (_params.onStart)
			{
				var startCallback : Function = _params.onStart;
				var startEvent : AssetLoadEvent = new AssetLoadEvent(AssetLoadEvent.LOAD_START);
				startEvent.id = _id;
				startCallback(startEvent);
			}
		}

		private function onError(event : IOErrorEvent) : void
		{
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			if (_params.onError)
			{
				var errorCallback : Function = _params.onError;
				var errorEvent : AssetLoadEvent = new AssetLoadEvent(AssetLoadEvent.LOAD_ERROR);
				errorEvent.error = new Error("IOError");
				errorEvent.id = _id;
				errorCallback(errorEvent);
			}
			else
			{
				throw new Error("These are not the droids you are looking for.");
			}
		}

		private function onProgress(event : ProgressEvent) : void
		{
			if (_params.onProgress)
			{
				var progressCallback : Function = _params.onProgress;

				var progressEvent : AssetLoadEvent = new AssetLoadEvent(AssetLoadEvent.LOAD_PROGRESS);
				progressEvent.id = _id;
				progressEvent.bytesLoaded = event.bytesLoaded;
				progressEvent.bytesTotal = event.bytesTotal;
				progressEvent.percentage = (event.bytesLoaded / event.bytesTotal) * 100;
				progressEvent.roundPercentage = Math.round(progressEvent.percentage);
				progressCallback(progressEvent);
			}
		}

		private function onComplete(event : Event) : void
		{
			// major nasty workaround for something I don't know why happen;
			if (!_loaded)
			{
				event.currentTarget.removeEventListener(Event.COMPLETE, onComplete);

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
				_loaded = true;
				onCompleteCallback();
			}
		}

		private function onCompleteCallback() : void
		{
			var event : AssetLoadEvent = new AssetLoadEvent(AssetLoadEvent.LOAD_COMPLETE);
			event.id = _id;
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