package com.humboldtjs.hjsunit
{
	import com.humboldtjs.events.EventDispatcher;
	import com.humboldtjs.events.HJSEvent;
	import com.humboldtjs.system.Logger;
	
	import dom.window;
	
	public class TestRunnerBase extends EventDispatcher
	{
		protected var _assert:Assert;
		protected var _testSuite:TestSuite;
		
		protected var _testsCount:int;
		protected var _testsPassed:int;
		protected var _testsFailed:int;
		protected var _testMethodsCount:int;
		protected var _testMethodsPassed:int;
		protected var _testMethodsFailed:int;
		
		public function TestRunnerBase()
		{
			super();
		}
		
		protected function clear():void
		{
			// clear the page
		}
		
		protected function passed(aName:String, aDetail:String):void
		{
			// log that a test has passed
		}
		
		protected function failed(aName:String, aDetail:String):void
		{
			// log that a test has failed
		}
		
		protected function suiteTitle(aName:String):void
		{
			// display the start of a test-suite
		}
		
		protected function testTitle(aName:String):void
		{
			// display the start of a test
		}
		
		protected function testComplete():void
		{
			// display the results of a test	
		}
		
		protected function suiteComplete():void
		{
			// display the results of a test-suite
		}
		
		public function run(aTestSuite:TestSuite):void
		{
			clear();
			
			_assert = new Assert();
			_assert.addEventListener(TestMessageEvent.TEST_MESSAGE, onTest);
			
			_testSuite = aTestSuite;
			_testSuite.addEventListener(HJSEvent.COMPLETE, onComplete);
			
			window.setTimeout(doRun, 0);
		}
		
		protected function doRun():void
		{
			_testsCount = 0;
			_testsPassed = 0;
			_testsFailed = 0;
			_testMethodsCount = 0;
			_testMethodsPassed = 0;
			_testMethodsFailed = 0;
			
			_testSuite.run(_assert);
		}
		
		protected function onComplete(aEvent:HJSEvent):void
		{
			_assert.removeEventListener(TestMessageEvent.TEST_MESSAGE, onTest);
			_testSuite.removeEventListener(HJSEvent.COMPLETE, onComplete);
			
			finishTest();
			finishSuite();
			
			dispatchEvent(new HJSEvent(HJSEvent.COMPLETE));
		}
		
		protected function finishSuite():void
		{
			suiteComplete();
		}
		
		protected function finishTest():void
		{
			if (_testMethodsCount == 0) return;

			testComplete();
			
			_testsCount++;
			if (_testMethodsPassed == _testMethodsCount)
				_testsPassed++;
			else
				_testsFailed++;
			
			_testMethodsPassed = 0;
			_testMethodsFailed = 0;
			_testMethodsCount = 0;
		}
		
		protected function onTest(aEvent:TestMessageEvent):void
		{
			switch (aEvent.subType) {
				case TestMessageEvent.TEST_PASSED:
					_testMethodsCount++;
					_testMethodsPassed++;
					
					passed(aEvent.name, aEvent.detail);
					break;
				case TestMessageEvent.TEST_FAILED:
					_testMethodsCount++;
					_testMethodsFailed++;

					failed(aEvent.name, aEvent.detail);
					break;
				case TestMessageEvent.TEST_TITLE:
					finishTest();

					testTitle(aEvent.name);
					break;
				case TestMessageEvent.TEST_SUITE_TITLE:
					finishTest();

					suiteTitle(aEvent.name);
					break;
			}
		}
	}
}