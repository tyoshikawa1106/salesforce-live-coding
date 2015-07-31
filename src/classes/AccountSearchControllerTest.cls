@isTest
private class AccountSearchControllerTest {

    private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * コンストラクタ
     */
    static testMethod void AccountSearchControllerTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            AccountSearchController cls = new AccountSearchController();
            
            Test.stopTest();

            System.assertEquals(cls.accounts.size(), 0);
        }
    }

    /**
     * 検索
     * テストデータなし
     */
    static testMethod void doSearchTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            AccountSearchController cls = new AccountSearchController();
            cls.doSearch();
            
            Test.stopTest();

            System.assertEquals(cls.accounts.size(), 0);
        }
    }

    /**
     * 検索
     * テストデータあり
     */
    static testMethod void doSearchTest2() {
        
        System.runAs(testAdminUser) {

            // 取引先テストデータ
            Account account = CommonTester.createAccount(true);

            Test.startTest();
            
            AccountSearchController cls = new AccountSearchController();
            cls.doSearch();
            
            Test.stopTest();

            System.assertEquals(cls.accounts.size(), 1);
        }
    }
}