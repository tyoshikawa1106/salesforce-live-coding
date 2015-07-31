@isTest
private class ContactTriggerHelperTest {

    private static ContactTriggerHelper helper = new ContactTriggerHelper();
    private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * 取引先ID情報を取得
     * テストデータなし
     */
    static testMethod void getAccountIdMapTest1() {
        
        System.runAs(testAdminUser) {

            List<Contact> contacts = new List<Contact>();

            Test.startTest();
            
            Map<Id, List<Contact>> results = helper.getAccountIdMap(contacts);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * 取引先ID情報を取得
     * テストデータあり
     */
    static testMethod void getAccountIdMapTest2() {
        
        System.runAs(testAdminUser) {

            // テストデータ作成
            Account account = CommonTester.createAccount(true);
            Contact contact = CommonTester.createContact(account, true);

            List<Contact> contacts = new List<Contact>();
            contacts.add(contact);
            System.assertEquals(contacts.size(), 1);

            Test.startTest();
            
            Map<Id, List<Contact>> results = helper.getAccountIdMap(contacts);
            
            Test.stopTest();

            System.assertEquals(results.size(), 1);
            System.assertEquals(results.get(account.Id).size(), 1);
        }
    }

    /**
     * 取引先ID情報を取得
     * テストデータあり (取引先IDなし)
     */
    static testMethod void getAccountIdMapTest3() {
        
        System.runAs(testAdminUser) {

            // テストデータ作成
            Contact contact = CommonTester.createContact(new Account(), true);

            List<Contact> contacts = new List<Contact>();
            contacts.add(contact);
            System.assertEquals(contacts.size(), 1);

            Test.startTest();
            
            Map<Id, List<Contact>> results = helper.getAccountIdMap(contacts);
            
            Test.stopTest();

            System.assertEquals(results.size(), 0);
        }
    }

    /**
     * 取引先ID情報を取得
     * テストデータなし
     */
    static testMethod void getAccountIdMapByUpdateTest1() {
        
        System.runAs(testAdminUser) {

            List<Contact> contacts = new List<Contact>();
            Map<Id, Contact> contactOldMap = new Map<Id, Contact>();

            Test.startTest();
            
            Map<Id, List<Contact>> results = helper.getAccountIdMap(contacts, contactOldMap);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * 取引先ID情報を取得
     * テストデータあり (取引先ID変更なし)
     */
    static testMethod void getAccountIdMapByUpdateTest2() {
        
        System.runAs(testAdminUser) {

            // テストデータ作成
            Account account = CommonTester.createAccount(true);
            Contact contact = CommonTester.createContact(account, true);

            // パラメータ
            List<Contact> contacts = new List<Contact>();
            contacts.add(contact);

            // OldMap
            Contact oldContact = contact.clone(true, false, true, true);
            Map<Id, Contact> contactOldMap = new Map<Id, Contact>();
            contactOldMap.put(oldContact.Id, oldContact);

            // 取引先判定
            System.assertEquals(contact.AccountId, oldContact.AccountId);

            Test.startTest();
            
            Map<Id, List<Contact>> results = helper.getAccountIdMap(contacts, contactOldMap);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

     /**
     * 取引先ID情報を取得
     * テストデータあり (取引先ID変更あり)
     */
    static testMethod void getAccountIdMapByUpdateTest3() {
        
        System.runAs(testAdminUser) {

            // テストデータ作成
            Account account = CommonTester.createAccount(true);
            Contact contact = CommonTester.createContact(account, true);

            // 変更後取引先
            Account accountOther = CommonTester.createAccount(true);

            // パラメータ
            List<Contact> contacts = new List<Contact>();
            contacts.add(contact);

            // OldMap
            Contact oldContact = contact.clone(true, false, true, true);
            oldContact.AccountId = accountOther.Id;
            update oldContact;

            Map<Id, Contact> contactOldMap = new Map<Id, Contact>();
            contactOldMap.put(oldContact.Id, oldContact);

            // 取引先判定
            System.assertNotEquals(contact.AccountId, oldContact.AccountId);

            Test.startTest();
            
            Map<Id, List<Contact>> results = helper.getAccountIdMap(contacts, contactOldMap);
            
            Test.stopTest();

            System.assertEquals(results.size(), 2);
            System.assertEquals(results.get(account.Id).size(), 1);
            System.assertEquals(results.get(accountOther.Id).size(), 1);
        }
    }

    /**
     * 取引先責任者件数をセット
     * テストデータなし
     */
    static testMethod void setContactCntTest1() {
        
        System.runAs(testAdminUser) {

            List<Account> accounts = new List<Account>();

            Test.startTest();
            
            helper.setContactCnt(accounts);
            
            Test.stopTest();

            System.assertEquals(accounts.isEmpty(), true);
        }
    }

    /**
     * 取引先責任者件数をセット
     * テストデータあり
     */
    static testMethod void setContactCntTest2() {
        
        System.runAs(testAdminUser) {

            // テストデータ作成
            Account account = CommonTester.createAccount(true);
            Contact contact = CommonTester.createContact(account, true);

            // パラメータ
            List<Account> accounts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id =: account.Id LIMIT 10];

            Test.startTest();
            
            helper.setContactCnt(accounts);
            
            Test.stopTest();

            System.assertEquals(accounts.size(), 1);
            System.assertEquals(accounts[0].ContactCnt__c, 1);
        }
    }

    /**
     * DMLエラー判定
     * テストデータなし
     */
    static testMethod void isDmlErrorTest1() {
        
        System.runAs(testAdminUser) {

            List<Database.Saveresult> results = new List<Database.Saveresult>();
            List<Account> accounts = new List<Account>();
            Map<Id, Contact> contactMap = new Map<Id, Contact>();
            Map<Id, List<Contact>> accountIdKeyMap = new Map<Id, List<Contact>>();

            Test.startTest();
            
            helper.isDmlError(results, accounts, contactMap, accountIdKeyMap);
            
            Test.stopTest();
        }
    }

    /**
     * DMLエラー判定
     * テストデータあり
     */
    static testMethod void isDmlErrorTest2() {
        
        System.runAs(testAdminUser) {

            List<Account> testAccounts = new List<Account>();
            for (Integer i = 0; i < 5; i++) {
                Account a = CommonTester.createAccount(false);
                testAccounts.add(a);
            }
            insert testAccounts;

            List<Contact> testContacts = new List<Contact>();
            for (Integer i = 0; i < 5; i++) {
                Contact c = CommonTester.createContact(testAccounts[i], false);
                testContacts.add(c);
            }
            insert testContacts;

            List<Database.Saveresult> results = Database.Update(testAccounts, false);
            List<Account> accounts = new List<Account>();
            Map<Id, Contact> contactMap = new Map<Id, Contact>();
            Map<Id, List<Contact>> accountIdKeyMap = new Map<Id, List<Contact>>();

            Test.startTest();
            
            helper.isDmlError(results, accounts, contactMap, accountIdKeyMap);
            
            Test.stopTest();

            Integer i = 0;
            for (Database.SaveResult sr : results) {
                System.assertEquals(sr.isSuccess(), true);
                if (sr.isSuccess()) {
                    System.assertEquals(sr.getId(), testAccounts[i].Id);
                }
                i++;
            }
        }
    }
}