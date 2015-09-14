@isTest
private class OpportunityCopyBatchDaoTest {

	private static OpportunityCopyBatchDao dao = new OpportunityCopyBatchDao();
    private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * 商談情報取得
     * 取得結果0件
     */
    static testMethod void getOpportunitiesTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            Database.QueryLocator result = dao.getOpportunities();
            
            Test.stopTest();

            // Result
            String resultQuery = result.getQuery();
            System.assertEquals(String.isNotEmpty(resultQuery), true);
            // Query
            List<Opportunity> resultOpportunities = database.query(resultQuery);
            System.assertEquals(resultOpportunities.isEmpty(), true);
        }
    }

    /**
     * 商談情報取得
     * 取得結果1件
     */
    static testMethod void getOpportunitiesTest2() {
        
        System.runAs(testAdminUser) {

            Account account = CommonTester.createAccount(true);
            Opportunity opportunity = CommonTester.createOpportunity(account, false);
            opportunity.StageName = 'Closed Won';
            opportunity.IsCopy__c = false;
            insert opportunity;

            Test.startTest();
            
            Database.QueryLocator result = dao.getOpportunities();
            
            Test.stopTest();

            // Result
            String resultQuery = result.getQuery();
            System.assertEquals(String.isNotEmpty(resultQuery), true);
            // Query
            List<Opportunity> resultOpportunities = database.query(resultQuery);
            System.assertEquals(resultOpportunities.size(), 1);
        }
    }
}