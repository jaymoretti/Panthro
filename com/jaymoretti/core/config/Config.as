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
package com.jaymoretti.core.config
{
	import com.jaymoretti.events.AssetLoadEvent;
	import com.jaymoretti.loading.types.AssetTypes;
	import com.jaymoretti.core.debug.LogBook;
	import com.jaymoretti.events.ConfigEvent;
	import com.jaymoretti.loading.AssetLoader;
	import flash.display.Sprite;


	public class Config extends Sprite
	{
		public static var SOUND_LIST:Array = [];
		
		private var _configFile : String;
		private var _configData : XML;
		private var _pages : Array;
		private var _gateways : Object;
		private var _background : Object;
		private var _parameters : Object;
		private var _fonts : Object;
		
		private static var _configObject : Object;

		public function set configFile(configFile : String) : void
		{
			if (!_configFile)
			{
				_configFile = configFile;
				loadConfig();
			}
			else
			{
				LogBook.log("You can't have more than one config file");
			}
		}

		private function loadConfig() : void
		{

			AssetLoader.loadAsset({url:_configFile, type:AssetTypes.XML, onError:onError, onComplete:onComplete});
		}

		private function onComplete(event : AssetLoadEvent) : void
		{
			_configData = event.content;

			if (!_configData)
			{
				LogBook.log("xml not loaded");
				dispatchEvent(new ConfigEvent(ConfigEvent.CONFIG_ERROR));
			}
			else
			{
				if (!_configData.parameters)
				{
					LogBook.log("Malformed XML: No parameters found.");
					dispatchEvent(new ConfigEvent(ConfigEvent.CONFIG_ERROR));
				}
				else
				{
					getParameters();
				}
			}
		}

		private function onError(event : AssetLoadEvent) : void
		{
			dispatchEvent(new ConfigEvent(ConfigEvent.CONFIG_ERROR));
		}

		private function getParameters() : void
		{
			_parameters = {};
			for each (var _node:XML in _configData.parameters.children())
			{
				if (_node.children().length() > 1)
				{
					if (_node.localName() == "background")
					{
						var backgroundData : XML = _node;
						var backgroundScale : String;

						if (backgroundData.elements("scale").length() > 0)
						{
							backgroundScale = backgroundData.scale.type;
						}
						else
						{
							backgroundScale = "noScale";
						}

						if (backgroundData.type == "video" || backgroundData.type == "image")
						{
							_background = {type:backgroundData.type, contentPath:backgroundData.contentPath, scale:backgroundScale, alignment:backgroundData.alignment};
						}
						else if (backgroundData.type == "gradient")
						{
							_background = {type:backgroundData.type, gradientType:backgroundData.gradientType, baseColor:backgroundData.baseColor, secondaryColor:backgroundData.secondaryColor, focalPoint:backgroundData.focalPoint, scale:"FIT", alignment:"CENTER"};
						}
						else if (backgroundData.type == "solid")
						{
							_background = {type:backgroundData.type, color:backgroundData.color, scale:"FIT", alignment:"CENTER"};
						}
						_parameters.background = _background;
					}
					else if (_node.localName() == "gateway")
					{
						_gateways = {local:_node.child(0), main:_node.child(1)};

						_parameters.gateways = _gateways;
					}
				}
				else
				{
					var nodeVal : String = _node;
					var basepath : RegExp = /%\(basepath\)s/;
					var locale : RegExp = /%\(locale\)s/;
					var locales : RegExp = /%\(locales\)s/;
					var pagepath : RegExp = /%\(pagespath\)s/;

					if ((basepath.test(nodeVal)))
					{
						nodeVal = nodeVal.replace(basepath, _parameters.basepath);
					}
					if ((locale.test(nodeVal)))
					{
						nodeVal = nodeVal.replace(locale, _parameters.locale);
					}
					if ((locales.test(nodeVal)))
					{
						nodeVal = nodeVal.replace(locales, _parameters.locales);
					}
					if (pagepath.test(nodeVal))
					{
						nodeVal = nodeVal.replace(pagepath, _parameters.pagespath);
					}
					_parameters[_node.localName()] = nodeVal;
				}
			}
			if (_configData.fonts)
			{
				getFonts();
			}
			if (_configData.site)
			{
				getPages();
			}

			_configObject = parameters;
			dispatchEvent(new ConfigEvent(ConfigEvent.CONFIG_LOADED));
		}

		private function getPages() : void
		{
			var pageObject : Object;
			_pages = [];

			for each (var pageNode:XML in _configData.site.children())
			{
				pageObject = {};
				for each (var confNode:XML in pageNode.children())
				{
					if (confNode.children().length() == 1)
					{
						var nodeVal : String = confNode;
						var title : RegExp = /%\(title\)s/;

						if ((title.test(nodeVal)))
						{
							nodeVal = nodeVal.replace(title, _parameters.title);
						}
						pageObject[confNode.localName()] = nodeVal;
					}
					else
					{
						pageObject[confNode.localName()] = {};

						for each (var depNode:XML in confNode.children())
						{
							var depVal : String = depNode;
							var commonpath : RegExp = /%\(commonpath\)s/;
							var pagepath : RegExp = /%\(pagespath\)s/;

							if ((commonpath.test(depVal)))
							{
								depVal = depVal.replace(commonpath, _parameters.commonpath);
							}
							if (pagepath.test(depVal))
							{
								depVal = depVal.replace(pagepath, _parameters.pagespath);
							}
							pageObject[confNode.localName()][depNode.localName()] = depVal;
						}
					}
				}
				_pages.push(pageObject);
			}
			_parameters.pages = _pages;
		}

		private function getFonts() : void
		{
			_fonts = {};
			for each (var _node:XML in _configData.fonts.children())
			{
				_fonts[_node.name] = {};

				for each (var depNode:XML in _node.children())
				{
					var depVal : String = depNode;
					var commonpath : RegExp = /%\(commonpath\)s/;

					if ((commonpath.test(depVal)))
					{
						depVal = depVal.replace(commonpath, _parameters.commonpath);
					}

					_fonts[_node.name][depNode.localName()] = depVal;
				}
			}
			_parameters.fonts = _fonts;
		}

		public function get parameters() : Object
		{
			return _parameters;
		}

		static public function get configObject() : Object
		{
			return _configObject;
		}
	}
}