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
	
	public class PageEvent extends Event
	{
		public static const PAGE_IN:String = "PageIn";
		public static const PAGE_OUT:String = "PageOut";
		public static const PAGE_READY:String = "PageReady";
		public static const PAGE_LOADING:String = "PageLoading";
		
		public function PageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		public override function clone():Event
		{
			return new PageEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("PageEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}