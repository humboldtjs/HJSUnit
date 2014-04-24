package com.humboldtjs.hjsunit
{
	import com.humboldtjs.events.IEventDispatcher;

	public interface ITestRunnable extends IEventDispatcher
	{
		function run(assert:Assert):void; 
	}
}