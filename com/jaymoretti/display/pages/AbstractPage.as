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
package com.jaymoretti.display.pages
{
	import com.jaymoretti.display.views.PView;
	import com.jaymoretti.events.PageEvent;

	import flash.display.Sprite;

	public class AbstractPage extends PView implements IPage{
		private var _container:Sprite;
		private var _configProperties : Object = {id:""};
		
		
		public function AbstractPage() {
			super();
		}
		
		override public function init(params : Object = null) : void
		{
			dispatchEvent(new PageEvent(PageEvent.PAGE_LOADING));
			
			if(!_configProperties)
			{
				_configProperties = {};
				_configProperties.id = 3; 
				pageReady();
			} else {
				dispatchEvent(new PageEvent(PageEvent.PAGE_READY));
			}
		}

		public function pageReady() : void {
			dispatchEvent(new PageEvent(PageEvent.PAGE_READY));
		}
		
		public function loadDependencies(path:String) : void {
			// Always override this method
				
		}

		override public function animateIn() : void {
			this.alpha = 1;
		}

		override public function animateOut() : void {
			this.alpha = 0;
		}

		public function deeplink() : void {
		}

		public function get id() : String {
			return _configProperties.id;
		}
	}
}
