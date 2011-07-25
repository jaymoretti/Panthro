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
package com.jaymoretti.events
{
	import flash.events.Event;

	public class BatchAssetLoadEvent extends Event
	{
		public static const LOAD_ERROR : String = "BatchAssetLoadError";
		public static const ITEM_LOAD_ERROR : String = "BatchAssetIemLoadError";
		public static const LOAD_COMPLETE : String = "BatchAssetLoadComplete";
		public static const ITEM_LOAD_COMPLETE : String = "BatchAssetItemLoadComplete";
		public static const LOAD_PROGRESS : String = "BatchAssetLoadProgress";
		public static const ITEM_LOAD_PROGRESS : String = "BatchAssetItemLoadProgress";
		public static const LOAD_START : String = "BatchAssetLoadStart";
		
		public var percentage : Number;
		public var roundPercentage:int, bytesTotal:int,  bytesLoaded : int;
		public var content : *;
		public var batchID : String, itemID : String, itemPath : String;
		public var error : Error;

		public function BatchAssetLoadEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		public override function clone() : Event
		{
			return new BatchAssetLoadEvent(type, bubbles, cancelable);
		}

		public override function toString() : String
		{
			return formatToString("BatchAssetLoadEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}
