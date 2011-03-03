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
package com.jaymoretti.core.application
{
	import com.jaymoretti.display.IPView;
	import flash.display.Sprite;
	public class PApplication extends Sprite implements IApplication
	{
		public function PApplication() {
			super();
		}

		public function init(params : Object = null) : void
		{
		}

		public function freeze() : void
		{
			for each (var child : IPView in this) {
				child.freeze();
			}
		}

		public function resume() : void
		{
			for each (var child : IPView in this) {
				child.resume();
			}
		}

		public function getInstance() : IApplication
		{
			return this;
		}
	}
}
