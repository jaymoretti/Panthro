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
package com.jaymoretti.loading
{

	import com.jaymoretti.core.events.AssetLoadEvent;
	import com.jaymoretti.display.PAsset;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;


	public class AssetLoader extends BasicLoader
	{
		private var dispatcher : EventDispatcher;
		private var loader : Loader;
		private var _asset : *;
		private var _cueID : Number;
		private var _progress : Number;
		
		public function AssetLoader() {
			super();
		}

		override public function loadComplete(event : Event) : void
		{
			var loadedEvent : AssetLoadEvent = new AssetLoadEvent(AssetLoadEvent.LOAD_COMPLETE);

				_asset = event.currentTarget.content as PAsset;
			if (getQualifiedClassName(event.currentTarget.content) == "flash.display::Bitmap")
			{
				Bitmap(event.currentTarget.content).smoothing = true;
			}
			loadedEvent.content = event.currentTarget.content;
			dispatchEvent(loadedEvent);
		}
	}
}