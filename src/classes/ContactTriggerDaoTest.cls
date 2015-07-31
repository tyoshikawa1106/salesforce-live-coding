@isTest
private class ContactTriggerDaoTest {

    private static ContactTriggerDao dao = new ContactTriggerDao();
    private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * 取引先責任者の件数を取得
     * テストデータなし
     */
    static testMethod void getAccountContactCntTest1() {
        
        System.runAs(testAdminUser) {

            Set<Id> accountIds = new Set<Id>();

            Test.startTest();
            
            List<Account> accounts = dao.getAccountContactCnt(accountIds);
            
            Test.stopTest();

            System.assertEquals(accounts.size(), 0);
        }
    }

    /**
     * 取引先責任者の件数を取得
     * テストデータあり
     */
    static testMethod void getAccountContactCntTest2() {
        
        System.runAs(testAdminUser) {

            // テストデータ作成
            Account account = CommonTester.createAccount(true);
            Contact contact = CommonTester.createContact(account, true);
            System.assertEquals(contact.AccountId, account.Id);

            // パラメータ
            Set<Id> accountIds = new Set<Id>();
            accountIds.add(account.Id);

            Test.startTest();
            
            List<Account> accounts = dao.getAccountContactCnt(accountIds);
            
            Test.stopTest();

            System.assertEquals(accounts.size(), 1);
            System.assertEquals(accounts[0].Contacts.size(), 1);
        }
    }
}