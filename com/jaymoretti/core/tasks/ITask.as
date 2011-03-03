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
package com.jaymoretti.core.tasks
{
	public interface ITask
	{
		function execute() : void;

		function pause() : void;

		function resume() : void;

		function completed() : void;
		
		function completeCallback(callback: Function):void;

		function addEventListener(eventType : String, eventListener : Function, useCapture : Boolean = false, eventPriority : int = 0, useWeakReference : Boolean = false) : void

		function removeEventListener(eventType : String, eventListener : Function) : void

		function dispatchEvent(event : *) : void
	}
}
