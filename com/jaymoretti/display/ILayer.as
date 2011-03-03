/******************************************************************************
 * 			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 * 					Version 2, December 2004
 * 
 * Copyright (C) Mar 2, 2011 - Jay Moretti <jrmoretti@gmail.com>
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
package com.jaymoretti.display
{
	import flash.display.DisplayObject;
	public interface ILayer
	{
		function add(child:DisplayObject, params:Object):void;
		function addAt(child:DisplayObject, index:int, params:Object):void;
		function clear():void;
		function show():void;
		function hide():void;
		function remove(target:DisplayObject):void;
		function removeFrom(index:int):void;
	}
}
