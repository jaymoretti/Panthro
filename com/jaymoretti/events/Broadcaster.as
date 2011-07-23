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
	import flash.events.EventDispatcher;

	public class Broadcaster 
	{
		protected var _dispatcher:EventDispatcher = new EventDispatcher();
		protected static var _instance:Broadcaster;
		
		private static function get instance():Broadcaster
		{
			if(!_instance)
				_instance = new Broadcaster();
				
			return _instance;
		}
		
		
		public static function addEventListener(eventType : String, eventListener : Function, useCapture : Boolean = false, eventPriority : int = 0, useWeakReference : Boolean = false) : void
		{
			instance._addEventListener(eventType, eventListener, useCapture, eventPriority, useWeakReference);
		}

		public static function removeEventListener(eventType : String, eventListener : Function) : void
		{
			instance._removeEventListener(eventType, eventListener);
		}

		public static function dispatchEvent(event : *) : void
		{
			instance._dispatchEvent(event);
		}
		
		private function _addEventListener(eventType : String, eventListener : Function, useCapture : Boolean = false, eventPriority : int = 0, useWeakReference : Boolean = false) : void
		{
			_dispatcher.addEventListener(eventType, eventListener, useCapture, eventPriority, useWeakReference);
		}

		private function _removeEventListener(eventType : String, eventListener : Function) : void
		{
			_dispatcher.removeEventListener(eventType, eventListener);
		}

		private function _dispatchEvent(event : *) : void
		{
			_dispatcher.dispatchEvent(event);
		}
	}
}
