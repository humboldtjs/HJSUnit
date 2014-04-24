package com.humboldtjs.hjsunit
{
	import com.humboldtjs.events.EventDispatcher;
	import com.humboldtjs.events.HJSEvent;
	
	public class TestCase extends TestBase
	{
		public function TestCase()
		{
			super();
		}
		
		protected function addTestMethod(aTestMethod:Test):void
		{
			_tests.push(aTestMethod);
		}

		override protected function prepareRun():void
		{
			_assert.title();
		}
	}
}