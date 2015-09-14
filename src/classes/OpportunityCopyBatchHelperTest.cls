@isTest
private class OpportunityCopyBatchHelperTest {

	private static OpportunityCopyBatchHelper helper = new OpportunityCopyBatchHelper();
    private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * 登録用の商談コピーリスト取得
     * 商談0件
     */
    static testMethod void getOpportunityCopyListTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            List<Opportunity> opportunities = new List<Opportunity>();
            List<OpportunityCopy__c> results = helper.getOpportunityCopyList(opportunities);
            
            Test.stopTest();

            // 商談コピーのリスト件数確認
            System.assertEquals(results.size(), 0);
        }
    }

    /**
     * 登録用の商談コピーリスト取得
     * 商談1件
     */
    static testMethod void getOpportunityCopyListTest2() {
        
        System.runAs(testAdminUser) {

            Account account = CommonTester.createAccount(true);
            Opportunity opportunity = CommonTester.createOpportunity(account, false);
            opportunity.StageName = 'Closed Won';
            opportunity.IsCopy__c = false;
            insert opportunity;

            List<Opportunity> opportunities = new List<Opportunity>();
            opportunities.add(opportunity);

            Test.startTest();
            
            // テスト実行
            List<OpportunityCopy__c> results = helper.getOpportunityCopyList(opportunities);
            
            Test.stopTest();

            // 商談コピーのリスト件数確認
            System.assertEquals(results.size(), 1);
            System.assertEquals(results[0].Name, opportunity.Name);
            System.assertEquals(results[0].StageName__c, opportunity.StageName);
            System.assertEquals(results[0].CloseDate__c, opportunity.CloseDate);
            // 商談コピー済みフラグ
            System.assertEquals(opportunity.IsCopy__c, true);
        }
    }
}