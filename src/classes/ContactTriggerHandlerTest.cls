@isTest
private class ContactTriggerHandlerTest {

    private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * 取引先ID情報を取得
     * INSERT
     */
    static testMethod void doUpdateContactCntByInsertTest1() {
        
        System.runAs(testAdminUser) {

            // テストデータ作成
            Account account = CommonTester.createAccount(true);

            Test.startTest();
            
            // INSERT
            Contact contact = CommonTester.createContact(account, true);
            
            Test.stopTest();

            Account resultAccount = [SELECT ContactCnt__c FROM Account WHERE Id =: account.Id LIMIT 1];
            System.assertEquals(resultAccount.ContactCnt__c, 1);
        }
    }

    /**
     * 取引先ID情報を取得
     * INSERT
     */
    static testMethod void doUpdateContactCntByInsertTest2() {
        
        System.runAs(testAdminUser) {

            // テストデータ作成
            Account account = CommonTester.createAccount(true);

            Test.startTest();
            
            // INSERT
            Contact contact1 = CommonTester.createContact(account, true);
            Contact contact2 = CommonTester.createContact(account, true);
            
            Test.stopTest();

            Account resultAccount = [SELECT ContactCnt__c FROM Account WHERE Id =: account.Id LIMIT 1];
            System.assertEquals(resultAccount.ContactCnt__c, 2);
        }
    }

    /**
     * 取引先ID情報を取得
     * INSERT
     */
    static testMethod void doUpdateContactCntByInsertTest3() {
        
        System.runAs(testAdminUser) {

            // テストデータ作成
            Account account = CommonTester.createAccount(true);

            Test.startTest();
            
            // INSERT
            List<Contact> contacts = new List<Contact>();
            for (Integer i = 0; i < 200; i++) {
                contacts.add(CommonTester.createContact(account, false));
            }
            insert contacts;
            
            Test.stopTest();

            Account resultAccount = [SELECT ContactCnt__c FROM Account WHERE Id =: account.Id LIMIT 1];
            System.assertEquals(resultAccount.ContactCnt__c, 200);
        }
    }

    /**
     * 取引先ID情報を取得
     * DELETE
     */
    static testMethod void doUpdateContactCntByDeleteTest1() {
        
        System.runAs(testAdminUser) {

            // テストデータ作成
            Account account = CommonTester.createAccount(true);
            Contact contact = CommonTester.createContact(account, true);

            Test.startTest();
            
            // DELETE
            delete contact;
            
            Test.stopTest();

            Account resultAccount = [SELECT ContactCnt__c FROM Account WHERE Id =: account.Id LIMIT 1];
            System.assertEquals(resultAccount.ContactCnt__c, 0);
        }
    }

    /**
     * 取引先ID情報を取得
     * DELETE
     */
    static testMethod void doUpdateContactCntByDeleteTest2() {
        
        System.runAs(testAdminUser) {

            // テストデータ作成
            Account account = CommonTester.createAccount(true);
            Contact contact = CommonTester.createContact(account, true);
            Contact contactOther = CommonTester.createContact(account, true);

            Test.startTest();
            
            // DELETE
            delete contact;
            
            Test.stopTest();

            Account resultAccount = [SELECT ContactCnt__c FROM Account WHERE Id =: account.Id LIMIT 1];
            System.assertEquals(resultAccount.ContactCnt__c, 1);
        }
    }

    /**
     * 取引先ID情報を取得
     * UNDELETE
     */
    static testMethod void doUpdateContactCntByUnDeleteTest1() {
        
        System.runAs(testAdminUser) {

            // テストデータ作成
            Account account = CommonTester.createAccount(true);
            Contact contact = CommonTester.createContact(account, true);

            Test.startTest();
            
            // DELETE
            delete contact;
            // UNDELETE
            undelete contact;
            
            Test.stopTest();

            Account resultAccount = [SELECT ContactCnt__c FROM Account WHERE Id =: account.Id LIMIT 1];
            System.assertEquals(resultAccount.ContactCnt__c, 1);
        }
    }

    /**
     * 取引先ID情報を取得
     * Update
     */
    static testMethod void doUpdateContactCntByUpdateTest1() {
        
        System.runAs(testAdminUser) {

            // テストデータ作成
            Account account = CommonTester.createAccount(true);
            Account accountOther = CommonTester.createAccount(true);

            Test.startTest();
            
            // INSERT
            Contact contact = CommonTester.createContact(account, true);
            // UPDATE
            contact.AccountId = accountOther.Id;
            update contact;
            
            Test.stopTest();

            Account resultAccount = [SELECT ContactCnt__c FROM Account WHERE Id =: account.Id LIMIT 1];
            System.assertEquals(resultAccount.ContactCnt__c, 0);

            Account resultAccountOther = [SELECT ContactCnt__c FROM Account WHERE Id =: accountOther.Id LIMIT 1];
            System.assertEquals(resultAccountOther.ContactCnt__c, 1);
        }
    }
}