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
package com.jaymoretti.display.views
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class PView extends Sprite implements IPView
	{
		public function PView()
		{
			super();
		}
		
		public function init(params : Object = null) : void
		{
			
		}

		public function destroy() : void
		{
			
		}

		public function animateIn() : void
		{
			// always override (preferably in the abstract object);
		}

		public function animateOut() : void
		{
			// always override (preferably in the abstract object);
		}

		public function freeze() : void
		{
			for each (var mc:MovieClip in this)
			{
				if (mc)
				{
					for (var j : int = 0; j != mc.numChildren - 1; j++)
					{
						var subMc : MovieClip = mc.getChildAt(j) as MovieClip;
						if (subMc)
						{
							subMc.stop();
						}
					}
					mc.stop();
				}
			}
		}

		public function resume() : void
		{
			for each (var mc:MovieClip in this)
			{
				if (mc)
				{
					for (var j : int = 0; j != mc.numChildren - 1; j++)
					{
						var subMc : MovieClip = mc.getChildAt(j) as MovieClip;
						if (subMc)
						{
							subMc.play();
						}
					}
					mc.play();
				}
			}
		}
	}
}
