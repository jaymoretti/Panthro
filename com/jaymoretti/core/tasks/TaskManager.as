/******************************************************************************
 * 			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 * 					Version 2, December 2004
 * 
 * Copyright (C) Feb 14, 2011 - Jay Moretti <jrmoretti@gmail.com>
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
package com.jaymoretti.core.tasks
{
	import flash.events.EventDispatcher;
	import com.jaymoretti.core.events.TaskManagerEvent;
	public class TaskManager
	{
		private static var taskList:Array = [];
		private static var isExecuting : Boolean = false;
		private static var isFirst : Boolean = true;
		private static var dispatcher : EventDispatcher;
		
		public static function addTask(task:ITask):void
		{
			task.completeCallback(executeTask);
			taskList.push(task);
			executeNextTask();
		}
		public static function stopAllTasks():void
		{
			isExecuting = false;
			taskList = [];
		}
		public static function getTaskLists():Array
		{
			return taskList;
		}
		private static function executeNextTask():void
		{
			if(!isExecuting)
			{
				executeTask();
			}
		}

		private static function executeTask() : void
		{
			isExecuting = false;
			if(taskList.length > 0)
			{
				if(isFirst)
				{
					isFirst = false;
					dispatchEvent(new TaskManagerEvent(TaskManagerEvent.TASKLIST_STARTED));
				}
				isExecuting = true;
				var task:ITask = taskList.shift() as ITask;
				task.execute();
			} else {
				isFirst = true;
				dispatchEvent(new TaskManagerEvent(TaskManagerEvent.TASKLIST_COMPLETED));
			}
		}
		
		public static function addEventListener(eventType : String, eventListener : Function, useCapture : Boolean = false, eventPriority : int = 0, useWeakReference : Boolean = false) : void
		{
			if(!dispatcher)
				dispatcher = new EventDispatcher();
				
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
	}
}
