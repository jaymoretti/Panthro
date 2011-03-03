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
package com.jaymoretti.utils.array
{
	public class ArrayUtils
	{
		public static function randomSort(array:Array):Array
		{
			var tempArray:Array = [];

			while (array.length > 0)
			{
				tempArray.push(array.splice(Math.round(Math.random() * (array.length - 1)), 1)[0]);
			}

			return tempArray;
		}

		public static function searchArray(value : *, array : Array) : Boolean
		{
			for (var i : int = 0; i != array.length; i++)
			{
				if (array[i] == value)
				{
					return true;
				}
			}
			return false;
		}

		public static function removeFromArray(value : *, array : Array) : Array
		{
			if(array.length > 0)
			{
				var length:Number = array.length;
				for (var i : int = 0; i != length; i++)
				{
					if (array[i] == value)
					{
						array.splice(i, 1);
					}
				}
			}
			return array;
		}
		public static function removeDuplicates(array:Array):Array
		{
			var tempArray:Array = [];
			for each(var i : * in array) {
				if(!searchArray(i, tempArray))
				{
					tempArray.push(i);
				}
			}
			return tempArray;
		}

		public static function getRandomValue(array : Array) : *
		{
			return array[Math.floor(Math.random()*array.length)];
		}
	}
}
