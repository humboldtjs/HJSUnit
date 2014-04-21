package com.humboldtjs.hjsunit
{
	import com.humboldtjs.events.HJSEvent;
	
	public class TestMessageEvent extends HJSEvent
	{
		public static const TEST_MESSAGE:String = "TestMessage";
		
		public static const TEST_PASSED:String = "TestPassed";
		public static const TEST_FAILED:String = "TestFailed";
		public static const TEST_TITLE:String = "TestTitle";
		public static const TEST_SUITE_TITLE:String = "TestSuiteTitle";
		
		public var subType:String;
		public var name:String;
		public var detail:String;
		
		public function TestMessageEvent(aSubType:String, aName:String, aDetail:String)
		{
			super(TestMessageEvent.TEST_MESSAGE);
			
			subType = aSubType;
			name = aName;
			detail = aDetail;
		}
	}
}