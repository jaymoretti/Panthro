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
	import com.jaymoretti.core.events.DependenciesEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;

	
	public class DependenciesLoader extends XMLLoader {
		private var dispatcher : EventDispatcher;
		private var _loader : URLLoader;
		private var _cueId : int;
		private var _url : String;
		private var _dependenciesData : XML;
		
		public function DependenciesLoader(url:String, id:int = 0):void {
			_url = url;
			_cueId = id;
			dispatcher = new EventDispatcher();	
			super();	
				
			load(url);
		}

		override public function loadError(event : IOErrorEvent) : void {
			
			var error:DependenciesEvent = new DependenciesEvent(DependenciesEvent.LOAD_ERROR);
			error.cueId = cueId;
						
			dispatcher.dispatchEvent(error);
		}

		override public function loadComplete(event : Event) : void {
			_dependenciesData = new XML(_loader.data);
			var dEvt : DependenciesEvent = new DependenciesEvent(DependenciesEvent.LOADED);
			dEvt.cueId = cueId;
			dEvt.content =  _dependenciesData;
			dispatcher.dispatchEvent(dEvt);
			
		}
		
		override public function get content() : *
		{
			return _dependenciesData;
		}
	}
}
