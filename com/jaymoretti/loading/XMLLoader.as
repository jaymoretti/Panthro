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
	import com.jaymoretti.core.events.XMLEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;


	public class XMLLoader extends BasicLoader
	{
		private var _loader : URLLoader;
		private var _xmlContent : XML;
		private var _path : String;

		public function XMLLoader()
		{
			super();
		}

		override public function loadComplete(event : Event) : void
		{
			XML.ignoreWhitespace = true;
			_xmlContent = new XML(_loader.data);
			var xmlEvent : XMLEvent = new XMLEvent(XMLEvent.LOAD_COMPLETE);
			xmlEvent.xml = _xmlContent;
			dispatchEvent(xmlEvent);
		}

		override public function loadError(event : IOErrorEvent) : void
		{
			dispatchEvent(new XMLEvent(XMLEvent.LOAD_ERROR));
		}

		override public function get content() : *
		{
			return _xmlContent;
		}
	}
}