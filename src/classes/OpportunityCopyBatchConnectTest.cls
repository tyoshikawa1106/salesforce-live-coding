@isTest
private class OpportunityCopyBatchConnectTest {
    
	private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * スケジュールバッチ
     */
    static testMethod void OpportunityCopyBatchConnectTest() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            OpportunityCopyBatchSchedule cls = new OpportunityCopyBatchSchedule();
            // パラメータ
            String sch = '20 30 8 10 2 ?';
            // バッチスケジュール起動
            System.schedule('OpportunityCopyBatchScheduleTestJob',sch, cls);  
            
            Test.stopTest();
        }
    }
}