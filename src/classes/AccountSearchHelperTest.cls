@isTest
private class AccountSearchHelperTest {

    private static AccountSearchHelper helper = new AccountSearchHelper();
    private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * リスト件数判定
     */
    static testMethod void isEmptyListTest1() {
        
        System.runAs(testAdminUser) {

            String message = 'ERROR!';

            Test.startTest();
            
            // リスト0件
            Integer listSize = 0;
            Boolean result = helper.isEmptyList(listSize, message);
            System.assertEquals(result, true);

            // リスト1件
            listSize = 1;
            result = helper.isEmptyList(listSize, message);
            System.assertEquals(result, false);
            
            Test.stopTest();
        }
    }
}