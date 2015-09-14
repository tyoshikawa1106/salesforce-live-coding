@isTest
private class CommonTesterTest {

    private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * テスト実行ユーザ取得
     */
    static testMethod void getLoginUserTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            User result = CommonTester.getLoginUser();
            System.assertEquals(result.Id, UserInfo.getUserId());
            
            Test.stopTest();
        }
    }

    /**
     * テスト実行ページ取得
     */
    static testMethod void getPageReferenceTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            PageReference result = CommonTester.getPageReference();
            System.assertEquals(result.getUrl(), new PageReference('PageReference').getUrl());
            
            Test.stopTest();
        }
    }
    
    /**
     * 取引先
     */
    static testMethod void createAccountTest() {

        System.runAs(testAdminUser) {
            Test.startTest();
            
            // Insertなし
            Account account = CommonTester.createAccount(false);
            System.assertEquals(String.isEmpty(account.Id), true);
            
            // Insertあり
            account = CommonTester.createAccount(true);
            System.assertEquals(String.isNotEmpty(account.Id), true);
            
            Test.stopTest();
        }
    }

    /**
     * 取引先責任者
     */
    static testMethod void createContactTest() {

        System.runAs(testAdminUser) {
            Account account = CommonTester.createAccount(true);
            
            Test.startTest();
            
            // Insertなし
            Contact contact = CommonTester.createContact(account, false);
            System.assertEquals(String.isEmpty(contact.Id), true);
            
            // Insertあり
            contact = CommonTester.createContact(account, true);
            System.assertEquals(String.isNotEmpty(contact.Id), true);
            
            Test.stopTest();
        }
    }

    /**
     * 商談
     */
    static testMethod void createOpportunityTest() {
        
        System.runAs(testAdminUser) {
            Account account = CommonTester.createAccount(true);
            
            Test.startTest();
            
            // Insertなし
            Opportunity opportunity = CommonTester.createOpportunity(account, false);
            System.assertEquals(String.isEmpty(opportunity.Id), true);
            
            // Insertあり
            opportunity = CommonTester.createOpportunity(account, true);
            System.assertEquals(String.isNotEmpty(opportunity.Id), true);
            
            Test.stopTest();
        }
    }
}