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
package com.jaymoretti.events
{
	import flash.events.Event;

	public class AssetLoadEvent extends Event
	{
		public static const LOAD_ERROR : String = "AssetLoadError";
		public static const LOAD_COMPLETE : String = "AssetLoadComplete";
		public static const LOAD_PROGRESS : String = "AssetLoadProgress";
		public static const LOAD_START : String = "AssetLoadStart";
		
		public var percentage : Number;
		public var roundPercentage:int, bytesTotal:int,  bytesLoaded : int;
		public var content : *;

		public function AssetLoadEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		public override function clone() : Event
		{
			return new AssetLoadEvent(type, bubbles, cancelable);
		}

		public override function toString() : String
		{
			return formatToString("AssetLoadEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}