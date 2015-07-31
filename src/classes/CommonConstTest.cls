@isTest
private class CommonConstTest {

    private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * コンストラクタ
     */
    static testMethod void CommonConstTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            CommonConst cls = new CommonConst();
            
            Test.stopTest();
        }
    }
}