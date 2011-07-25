/******************************************************************************
 * 			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 * 					Version 2, December 2004
 * 
 * Copyright (C) 2011 - Jay Moretti <jrmoretti@gmail.com>
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
package com.jaymoretti.utils.vector
{
	public class VectorUtils
	{
		public static function randomSort(vec:Vector.<*>):Vector.<*>
		{
			var tempVector:Vector.<*> = new Vector.<*>();

			while (vec.length > 0)
			{
				tempVector.push(vec.splice(Math.round(Math.random() * (vec.length - 1)), 1)[0]);
			}

			return tempVector;
		}

		public static function searchVector(value : *, property:String, vec : Vector.<*>) : Boolean
		{
			for (var prop:* in vec)
			{
				if(property == "*")
				{
					for(var itemProp:* in prop)
					{
						if(vec[prop][itemProp] == value)
							return true;
					}
				}else if (vec[prop][property] == value)
				{
					return true;
				}
			}
			return false;
		}

		public static function removeFromVector(item : *, vec : Vector.<*>) : Vector.<*>
		{
			if(vec.length > 0)
			{
				var length:Number = vec.length;
				for (var i : int = 0; i != length; i++)
				{
					if (vec[i] == item)
					{
						vec.splice(i, 1);
					}
				}
			}
			return vec;
		}
		public static function removeDuplicates(vec:Vector.<*>):Vector.<*>
		{
			var tempVector:Vector.<*> = new Vector.<*>();
			for each(var i : * in vec) {
				if(!searchVector(i, "*", tempVector))
				{
					tempVector.push(i);
				}
			}
			return tempVector;
		}

		public static function getRandomValue(vec : Vector.<*>) : *
		{
			return vec[Math.floor(Math.random()*vec.length)];
		}
		/*
		 * Returns first index of a value of any given property of any object inside the vector.
		 * 
		 * @params value The sought value
		 * 		   property the name of the property to look for, if you don't remember or want to search everywhere, use "*" as property name
		 * 		   vec The vector itself
		 * 		   
		 * @example VectorUtils.getFirstIndexOf("af7cd03e2baf0123", "uid", _userCredentialsVector);
		 * 
		 */
		public static function getFirstIndexOf(value:String, property:String, vec:Vector.<*>):int
		{
			
			for (var i:uint; i!= vec.length; i++)
			{
				if(property == "*")
				{
					for(var itemProp:* in vec[i])
					{
						if(vec[i][itemProp] == value)
							return i;
					}
				}else if (vec[i][property] == value)
				{
					return i;
				}
			}
			return -1;
		}
	}
}
