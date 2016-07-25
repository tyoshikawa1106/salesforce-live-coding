@isTest
private class OpportunityCopyBatchTest {

    private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * Execute
     * 商談0件
     */
    static testMethod void OpportunityCopyBatchTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            OpportunityCopyBatch batch = new OpportunityCopyBatch();
            Database.executeBatch(batch, 200);
            
            Test.stopTest();

            // 商談コピーの登録件数確認
            Integer result = [SELECT COUNT() FROM OpportunityCopy__c LIMIT 200];
            System.assertEquals(result, 0);
        }
    }

    /**
     * Execute
     * 商談1件 (コピー済みフラグ = False)
     */
    static testMethod void OpportunityCopyBatchTest2() {
        
        System.runAs(testAdminUser) {

            Account account = CommonTester.createAccount(true);
            Opportunity opportunity = CommonTester.createOpportunity(account, false);
            opportunity.StageName = 'Closed Won';
            opportunity.IsCopy__c = false;
            insert opportunity;

            Test.startTest();
            
            OpportunityCopyBatch batch = new OpportunityCopyBatch();
            Database.executeBatch(batch, 200);
            
            Test.stopTest();

            // 商談コピーの登録件数確認
            Integer result = [SELECT COUNT() FROM OpportunityCopy__c LIMIT 200];
            System.assertEquals(result, 1);
            // 商談のコピー済みフラグ
            Opportunity resultOpportunity = [SELECT Id,IsCopy__c FROM Opportunity WHERE Id =: opportunity.Id LIMIT 1];
            System.assertEquals(resultOpportunity.IsCopy__c, true);
        }
    }

    /**
     * Execute
     * 商談1件 (コピー済みフラグ = True)
     */
    static testMethod void OpportunityCopyBatchTest3() {
        
        System.runAs(testAdminUser) {

            Account account = CommonTester.createAccount(true);
            Opportunity opportunity = CommonTester.createOpportunity(account, false);
            opportunity.StageName = 'Closed Won';
            opportunity.IsCopy__c = true;
            insert opportunity;

            Test.startTest();
            
            OpportunityCopyBatch batch = new OpportunityCopyBatch();
            Database.executeBatch(batch, 200);
            
            Test.stopTest();

            // 商談コピーの登録件数確認
            Integer result = [SELECT COUNT() FROM OpportunityCopy__c LIMIT 200];
            System.assertEquals(result, 0);
        }
    }
}
