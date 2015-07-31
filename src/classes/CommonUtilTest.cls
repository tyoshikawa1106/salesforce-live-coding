@isTest
private class CommonUtilTest {

    private static User testAdminUser = CommonTester.getLoginUser();

    /**
     * URLパラメータ取得
     */
    static testMethod void getParametersTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            String result = '';
            
            // パラメータなし
            result = CommonUtil.getParameters(CommonConst.PARAM_ID);
            System.assertEquals(result, '');
            
            // パラメータあり
            PageReference pageRef = CommonTester.getPageReference();
            pageRef.getParameters().put(CommonConst.PARAM_ID, String.valueOf(UserInfo.getUserId()));
            
            Test.setCurrentPage(pageRef);
            
            result = CommonUtil.getParameters(CommonConst.PARAM_ID);
            System.assertEquals(result, String.valueOf(UserInfo.getUserId()));
            
            Test.stopTest();
        }
    }
    
    /**
     * 前画面URL存在判定
     */
    static testMethod void isReturnUrlTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            String check;
            PageReference result = null;
            PageReference retUrl = null;
            
            // 値なし
            check = '';
            result = CommonUtil.isReturnUrl(check);
            System.assertEquals(result.getUrl(), '/home/home.jsp');
            
            //　値あり
            check = '/ABC';
            result = CommonUtil.isReturnUrl(check);
            System.assertEquals(result.getUrl(), '/ABC');
            
            Test.stopTest();
        }
    }
    
    /**
     * 前画面遷移
     */
    static testMethod void getReturnUrlTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            PageReference pageRef = CommonTester.getPageReference();
            PageReference result;
            
            // パラメータなし
            result = CommonUtil.getReturnUrl();
            System.assertEquals(result.getUrl(), '/home/home.jsp');
            
            // パラメータあり
            pageRef.getParameters().put(CommonConst.PARAM_RETURN_URL, '/XXX');
            Test.setCurrentPage(pageRef);
            result = CommonUtil.getReturnUrl();
            System.assertEquals(result.getUrl(), '/XXX');
            
            Test.stopTest();
        }
    }
    
    /**
     * 正常系メッセージ表示
     */
    static testMethod void msgInfoTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            CommonUtil.msgInfo('Info');
            
            Test.stopTest();
        }
    }
    
    /**
     * 異常系メッセージ表示
     */
    static testMethod void msgErrorTest1() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            CommonUtil.msgError('Error');
            
            Test.stopTest();
        }
    }

    /**
     * 警告系メッセージ表示
     */
    static testMethod void msgWarningTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            CommonUtil.msgWarning('Warning');
            
            Test.stopTest();
        }
    }
    
    /**
     * DmlExceptionメッセージ表示
     */
    static testMethod void msgDmlErrorTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            try {
                Id checkId = 'Exception';
            } catch(Exception e) {
                CommonUtil.msgDmlError(e);
            }
            
            Test.stopTest();
        }
    }
    
    /**
     * Exceptionメッセージ表示
     */
    static testMethod void msgExceptionTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            try {
                Id checkId = 'Exception';
            } catch(Exception e) {
                CommonUtil.msgException(e);
            }
            
            Test.stopTest();
        }
    }
    
    /**
     * Exceptionメッセージを取得
     */
    static testMethod void toExceptionTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            try {
                // Exceptionエラー発生
                Id checkId = 'Exception';     
            } catch(Exception e) {
                CommonUtil.getExceptionMsg(e, 'Error');
            }
            Test.stopTest();
        }
    }
    
    /**
     * SingleQuote追加
     */
    static testMethod void toQueryTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();

            String check;
            String result;
            
            // 値なし
            check = '';
            result = CommonUtil.toQuery(check);
            System.assertEquals(result, '\'' + '\'');
            
            //　値あり
            check = 'XXX';
            result = CommonUtil.toQuery(check);
            System.assertEquals(result, '\'' + 'XXX' + '\'');

            Test.stopTest();
        }
    }
}