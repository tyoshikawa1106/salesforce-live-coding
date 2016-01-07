@isTest
private class OpportunityCopyBatchScheduleTest {

    private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * スケジュールバッチ
     */
    static testMethod void OpportunityCopyBatchScheduleTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            OpportunityCopyBatchSchedule cls = new OpportunityCopyBatchSchedule();
            // パラメータ
            String sch = '0 0 0 1 1 ?';
            // バッチスケジュール起動
            System.schedule('OpportunityCopyBatchScheduleTestJob',sch, cls);  
            
            Test.stopTest();
        }
    }
}
