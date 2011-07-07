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
package com.jaymoretti.display.layers
{
	import flash.display.DisplayObject;

	public class Layer extends PView implements ILayer
	{
		public function Layer()
		{
			super();
		}

		public function add(child:DisplayObject, params:Object) : void
		{
			if(params)
			{
				for each (var key : * in params)
					child[key] = params[key];
			}	
			addChild(child);	
		}

		public function addAt(child:DisplayObject, index:int, params:Object) : void
		{
			if(params)
			{
				for each (var key : * in params)
					child[key] = params[key];
			}
			addChildAt(child, index);
		}

		public function clear() : void
		{
			while(numChildren > 0)
				removeChildAt(0);
		}

		public function show() : void
		{
			visible = true;
		}

		public function hide() : void
		{
			visible = false;
		}

		public function remove(target : DisplayObject) : void
		{
			removeChild(target);
		}

		public function removeFrom(index : int) : void
		{
			removeChildAt(index);
		}
	}
}
