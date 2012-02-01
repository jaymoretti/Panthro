/******************************************************************************
 * 			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 * 					Version 2, December 2004
 * 
 * Copyright (C) 2011 - Jay Moretti <jrmoretti@gmail.com>
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
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	
	dynamic internal class AssetLoaderItem
	{
		private var stream:URLStream;
		public var size:uint = 0;
		public var loadProgress:Number = 0;
		public var loadedBytes:Number = 0;
		
		public function set params(params : Object) : void
		{
			if (!params.id)
				throw new Error("I can't work if you don't identify your asset");

			if (!params.type)
				throw new Error("I can't work if you don't tell me what are you loading");

			if (!params.url)
				throw new Error("I can't work if you don't tell me what to load");
				
			for(var param : * in params)
				this[param] = params[param];
				
			getFileSize();
		}
		
		private function getFileSize():void
		{
			stream = new URLStream();
			var request:URLRequest = new URLRequest(this.url);
			stream.addEventListener(ProgressEvent.PROGRESS, gotProgress);
			stream.load(request);
		}
		private function gotProgress(event:ProgressEvent):void
		{
			
			size = event.bytesTotal;
			stream.close();
		}
	}
}
