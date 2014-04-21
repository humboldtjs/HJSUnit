package com.humboldtjs.hjsunit
{
	import com.humboldtjs.events.EventDispatcher;
	import com.humboldtjs.events.HJSEvent;

	public class TestSuite extends TestBase
	{
		protected var _tests:Vector.<Test> = new Vector.<Test>();
		
		public function TestSuite()
		{
			super();
		}
		
		protected function addTest(aTest:Test):void
		{
			_tests.push(aTest);
		}
		
		public function run(assert:Assert = null):void
		{
			setAssert(assert);
			
			_assert.title(true);
			
			_queueIndex = 0;
			_queueCount = _tests.length;
			
			doQueue();
		}
		
		protected function doQueue():void
		{
			_tests[_queueIndex].addEventListener(HJSEvent.COMPLETE, onQueueItemComplete);
			_tests[_queueIndex].run(_assert);
		}
		
		protected function onQueueItemComplete(aEvent:HJSEvent):void
		{
			_tests[_queueIndex].removeEventListener(HJSEvent.COMPLETE, onQueueItemComplete);

			_queueIndex++;
			
			if (_queueIndex < _queueCount) {
				doQueue();
			} else {
				dispatchEvent(new HJSEvent(HJSEvent.COMPLETE));
			}
		}
	}
}