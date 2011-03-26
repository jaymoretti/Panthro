/******************************************************************************
 * 			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 * 					Version 2, December 2004
 * 
 * Copyright (C) Mar 2, 2011 - Jay Moretti <jrmoretti@gmail.com>
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
package com.jaymoretti.pages
{
	import com.jaymoretti.core.config.Config;
	
	dynamic public class Pages extends Object {
		public static function init() : void {
			for each(var i:* in Config.configObject.pages)
			{
				if(i.type == "internal")
					Pages[i.id] = {id: i.id, type:i.type, title: i.title, deeplink: i.deeplink, dependencies: i.dependencies, menuOptions:i.menuOptions};
				else if(i.type == "external")
					Pages[i.id] = {id: i.id, type:i.type, url: i.url, menuOptions:i.menuOptions};
			}
		}
	}
}
