@isTest
private class AccountSearchDaoTest {

    private static AccountSearchDao dao = new AccountSearchDao();
    private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * 取引先一覧取得
     * テストデータなし
     */
    static testMethod void getAccountsTest1() {
        
        System.runAs(testAdminUser) {

            Account account = new Account();

            Test.startTest();
            
            List<Account> accounts = dao.getAccounts(account);
            
            Test.stopTest();

            System.assertEquals(accounts.size(), 0);
        }
    }

    /**
     * 取引先一覧取得
     * テストデータあり
     */
    static testMethod void getAccountsTest2() {
        
        System.runAs(testAdminUser) {

            // 取引先テストデータ作成
            Account account = CommonTester.createAccount(true);

            Account acc = new Account();

            Test.startTest();
            
            List<Account> accounts = dao.getAccounts(acc);
            
            Test.stopTest();

            System.assertEquals(accounts.size(), 1);
        }
    }

    /**
     * 取引先一覧取得
     * 検索条件あり
     */
    static testMethod void getAccountsTest3() {
        
        System.runAs(testAdminUser) {

            // 取引先テストデータ作成
            Account account = CommonTester.createAccount(false);
            account.Name = 'Sample';
            account.AccountNumber = 'A-0001';
            insert account;

            // 検索条件
            Account acc = new Account(
                 Name = account.Name
                ,AccountNumber = account.AccountNumber
            );

            Test.startTest();
            
            List<Account> accounts = dao.getAccounts(acc);
            
            Test.stopTest();

            System.assertEquals(accounts.size(), 1);
        }
    }
}