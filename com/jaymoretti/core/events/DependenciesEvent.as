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
package com.jaymoretti.core.events
{
	import flash.events.Event;

	/**
	 * @author Jay Moretti
	 */
	public class DependenciesEvent extends Event {
		public static const LOADED : String = "dependenciesLoaded";
		public static const LOAD_ERROR : String = "dependenciesLoadError";
		public var content:XML; 
		public var cueId:int;
		
		public function DependenciesEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
		public override function clone():Event
		{
			return new DependenciesEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("DependenciesEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}
