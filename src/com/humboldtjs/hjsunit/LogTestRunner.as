package com.humboldtjs.hjsunit
{
	import com.humboldtjs.events.EventDispatcher;
	import com.humboldtjs.events.HJSEvent;
	import com.humboldtjs.system.Logger;
	
	import dom.window;

	public class LogTestRunner extends TestRunnerBase
	{
		protected var _title:Boolean;
		
		public function LogTestRunner()
		{
			super();
		}
		
		override protected function clear():void
		{
			window["console"].clear();
		}
		
		override protected function passed(aName:String, aDetail:String):void
		{
			Logger.log("Passed - " + aName + " - " + aDetail);
			_title = false;	
		}
		
		override protected function failed(aName:String, aDetail:String):void
		{
			Logger.error("Failed - " + aName + " - " + aDetail);
			_title = false;	
		}
		
		override protected function suiteTitle(aName:String):void
		{
			if (!_title)
				Logger.log("==================================================================================");
			Logger.log("Running test-suite: " + aName);
			Logger.log("==================================================================================");
			_title = true;	
		}
		
		override protected function testTitle(aName:String):void
		{
			if (!_title)
				Logger.log("----------------------------------------------------------------------------------");
			Logger.log("Running test-case: " + aName);
			Logger.log("----------------------------------------------------------------------------------");
			_title = true;	
		}
		
		override protected function message(aMessage:String):void
		{
			Logger.log(aMessage);
		}
		
		override protected function suiteComplete():void
		{
			Logger.log("==================================================================================");
			Logger.log("Suite Passed: " + _testsPassed + " Failed: " + _testsFailed + " Total: " + _testsCount);
			Logger.log("==================================================================================");
		}
		
		override protected function testComplete():void
		{
			if (!_title)
				Logger.log("----------------------------------------------------------------------------------");
			Logger.log("Case Passed: " + _testMethodsPassed + " Failed: " + _testMethodsFailed + " Total: " + _testMethodsCount);
		}
		
		override protected function doRun():void
		{
			_title = false;
			super.doRun();
		}
	}
}