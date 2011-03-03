
/******************************************************************************
 * 			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 * 					Version 2, December 2004
 * 
 * Copyright (C) Feb 9, 2011 - Jay Moretti <jrmoretti@gmail.com>
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
package com.jaymoretti.utils.dictionary
{

	import com.jaymoretti.utils.array.ArrayUtils;

	import flash.utils.Dictionary;

	public class DictionaryUtils
	{
		public static function randomSort(dictionary : Dictionary) : Dictionary
		{
			var tempDict : Dictionary = new Dictionary();
			var keys : Array = extractKeysFrom(dictionary);
			keys = ArrayUtils.randomSort(keys);

			for (var i : int = 0; i != keys.length; i++)
			{
				tempDict[i] = dictionary[keys[i]];
			}
			return tempDict;
		}

		private static function extractKeysFrom(source : Dictionary) : Array
		{
			var output : Array = [];

			for (var prop : * in source)
				output.push(prop);

			return output;
		}
	}
}
