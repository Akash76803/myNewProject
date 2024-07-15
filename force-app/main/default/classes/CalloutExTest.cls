@isTest
public class CalloutExTest {

    @isTest
    private static void test(){
        test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        CalloutEx.DoPost();
    }
}