
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
package com.jaymoretti.core.debug
{

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;

	public class LogBook
	{
		private static var server : String = "localhost";
		private static var _count : Number = 0;
		private static var socket : XMLSocket;
		private static var history : Array = [];
		private static var fieldSeparator : String = "--> ";

		public static function log(level:String = LogLevel.TRACE, ...params) : void
		{
			socket = new XMLSocket();
			var tempError : Error = new Error();
			var stackTrace : String = tempError.getStackTrace();
			var callerInfo : Array = stackTrace.split("\n");

			var caller : String = String(callerInfo[2]);
			caller = caller.replace("\t", "");

			caller = caller.substr("at".length);
			caller = caller.substring(0, caller.indexOf("["));
			caller += " ";

			var divider : String;
			divider = "";
			divider += ":~ $ ";

			++_count;

			var time : String;

			var currentTime : Date = new Date();
			var minutes : Number = currentTime.getMinutes();
			var seconds : Number = currentTime.getSeconds();
			var hours : Number = currentTime.getHours();

			time = hours + ":" + minutes + ":" + seconds + "s ";

			// trace( '---------------' );
			var message : String = _count + " " + time + caller + divider + params.join(', ');
			
			var logObject:Object = {message:message, level:level};

			if (socket.connected)
			{
				send(logObject);
			}
			else
			{
				if (!socket.hasEventListener("connect"))
				{
					socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
					socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
					socket.addEventListener(Event.CONNECT, onConnect);
				}
				socket.connect(server, 4444);
				history.push(logObject);
			}
		}

		private static function onIOError(e : IOErrorEvent) : void
		{
			trace("XMLSocket IOError");
		}

		private static function onSecurityError(e : SecurityErrorEvent) : void
		{
			trace("XMLSocket SecurityError");
		}

		private static function onConnect(e : Event) : void
		{
			for each (var logObject:Object in history)
			{
				send(logObject);
			}
			history = [];
		}

		private static function send(o : Object) : void
		{
			var msg : String = o.message;
			var lines : Array = msg.split("\n");
			var commandType : String = lines.length == 1 ? "showMessage" : "showFoldMessage";
			var key : String = o.level;
			var xmlMessage : XML = <{commandType} key={key} />;

			if (lines.length > 1)
			{
				// set title with first line
				xmlMessage.title = lines[0];

				// remove title from message
				xmlMessage.message = msg.substr(msg.indexOf("\n") + 1, msg.length);

				if (o.date == null)
					xmlMessage.data = o.data;
				if (o.time == null)
					xmlMessage.time = o.time;
				if (o.category == null)
					xmlMessage.category = o.category;
			}
			else
			{
				var prefix : String = "";
				if (o.date != null)
					prefix += o.date + fieldSeparator;
				if (o.time != null)
					prefix += o.time + fieldSeparator;
				if (o.category != null)
					prefix += o.category + fieldSeparator;

				xmlMessage.appendChild(prefix + msg);
			}

			socket.send('!SOS' + xmlMessage.toXMLString() + '\n');
		}

		public static function divider() : void
		{
			trace("__________________________________________________________________________________________________________________________________________");
		}
	}
}
