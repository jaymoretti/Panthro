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
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	public class BasicLoader implements ILoader
	{
		private var dispatcher : EventDispatcher;
		private var loader : Loader;
		private var _asset : *;
		private var _cueID : Number;
		private var _progress : Number;

		public function BasicLoader()
		{
			dispatcher = new EventDispatcher();
		}

		public function load(url : String) : void
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			loader.load(new URLRequest(url));
		}

		public function loadComplete(event : Event) : void
		{
		}

		public function onProgress(event : ProgressEvent) : void
		{
			_progress = (loader.contentLoaderInfo.bytesLoaded / loader.contentLoaderInfo.bytesTotal) * 100;
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
		}

		public function loadError(event : IOErrorEvent) : void
		{
			dispatchEvent(new AssetLoadEvent(AssetLoadEvent.LOAD_ERROR));
		}

		/*********
		 * EVENT DISPATCHER IMPLEMENTATION
		 */
		public function addEventListener(eventType : String, eventListener : Function, useCapture : Boolean = false, eventPriority : int = 0, useWeakReference : Boolean = false) : void
		{
			dispatcher.addEventListener(eventType, eventListener, useCapture, eventPriority, useWeakReference);
		}

		public function removeEventListener(eventType : String, eventListener : Function) : void
		{
			dispatcher.removeEventListener(eventType, eventListener);
		}

		public function dispatchEvent(event : *) : void
		{
			dispatcher.dispatchEvent(event);
		}

		public function set cueId(id : Number) : void
		{
			_cueID = id;
		}

		public function get cueId() : Number
		{
			return _cueID;
		}

		public function get content() : *
		{
			return _asset;
		}

		public function get progress() : Number
		{
			return _progress;
		}
	}
}
