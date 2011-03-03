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
package com.jaymoretti.utils.string
{
	public class StringUtils
	{
		public static function strReplace(search : String, replace : String, string : String) : String
		{
			var array : Array = string.split(search);
			return array.join(replace);
		}

		public static function capitalize(string : String) : String
		{
			var tempString : String = string.slice(1);
			string = string.charAt(0).toUpperCase() + tempString;
			return string;
		}

		public static function stripHTML(string : String) : String
		{
			return string.replace(/<.*?>/g, "");
		}

		public static function stripWhiteSpaces(string : String) : String
		{
			return string.replace(/ \t/g, "");
		}

		public static function camelCase(string : String) : String
		{
			var tempArray:Array = string.split(" ");
			string = "";
			for each(var word:String in tempArray)
			{
				string += capitalize(word)+" ";
			}
			return string;
		}
	}
}

