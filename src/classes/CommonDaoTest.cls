@isTest
private class CommonDaoTest {

    private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * ユーザ取得
     */
    static testMethod void getUserTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            // ログインユーザ取得
            User user = CommonDao.getUser();
            System.assertEquals(user.Id, UserInfo.getUserId());
            
            Test.stopTest();
        }
    }
}