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
package com.jaymoretti.net.remoting
{
	import com.jaymoretti.events.WebServiceEvent;

	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;


	final public class WebService
	{
		private static var _serviceURL : String = "";
		private static var _init : Boolean = false;
		private static var gateway : NetConnection;
		private static var _results : Object = {};
		public static var _url : String;
		protected static var dispatcher : EventDispatcher;

		/*********
		 * Init the webservice gateway
		 * @param url Gateway URL;
		 */
		public static function init(url : String) : void
		{
			
			
			if (!_init)
			{
				dispatcher = new EventDispatcher();
				gateway = new NetConnection();
				gateway.objectEncoding = ObjectEncoding.AMF3;
				gateway.addEventListener(NetStatusEvent.NET_STATUS, statusHandler);
				gateway.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				gateway.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);

				_serviceURL = url;
				gateway.connect(_serviceURL);

				_url = url.slice(0, url.length - 12);

				_init = true;
			
			}
		}

		/*********
		 * Call methods 
		 * @param method Method to be called (usually something from WebServiceCalls
		 * @param ... any parameters to be sent to the method.
		 */
		public static function call(method : String, ...parameters) : void
		{
			var responder : Responder = new Responder(onResult, onStatus);
			var args:Array = [method ,responder].concat(parameters);
			gateway.call.apply(WebService, args);
		}


		/*********
		 * EVENT DISPATCHER IMPLEMENTATION
		 */
		public static function addEventListener(eventType : String, eventListener : Function, useCapture : Boolean = false, eventPriority : int = 0, useWeakReference : Boolean = false) : void
		{
			dispatcher.addEventListener(eventType, eventListener, useCapture, eventPriority, useWeakReference);
		}

		public static function removeEventListener(eventType : String, eventListener : Function) : void
		{
			dispatcher.removeEventListener(eventType, eventListener);
		}

		public static function dispatchEvent(event : *) : void
		{
			dispatcher.dispatchEvent(event);
		}
		
		/*********
		 * HANDLERS
		 */
		private static function statusHandler(event : NetStatusEvent) : void
		{
			
		}

		private static function errorHandler(event : IOErrorEvent) : void
		{
						
		}

		private static function onResult(result : *) : void
		{
			sendResult(result, WebServiceEvent.DATA_READY);
		}
		
		private static function onStatus(result : *) : void
		{
			sendResult(result, WebServiceEvent.DATA_ERROR);
		}
		
		/*********
		 * Distribute the result to the listeners.
		 */
		private static function sendResult(result : *, event : String) : void
		{
			_results = {};
			_results = result;
			var resultEvent : WebServiceEvent = new WebServiceEvent(event);
			resultEvent.data = result;
			dispatchEvent(resultEvent);
		}

		
	}
}