package com.humboldtjs.hjsunit
{
	import com.humboldtjs.events.EventDispatcher;
	import com.humboldtjs.events.HJSEvent;

	public class TestSuite extends TestBase
	{
		public function TestSuite()
		{
			super();
		}
		
		protected function addTest(aTest:TestCase):void
		{
			_tests.push(aTest);
		}
		
		override protected function prepareRun():void
		{
			_assert.title(true);
		}
	}
}