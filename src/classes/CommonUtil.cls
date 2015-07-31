public with sharing class CommonUtil {

    /**
     * URLパラメータ取得
     */
    public static String getParameters(String prmValue) {
        
        String parameter = System.currentPageReference().getParameters().get(prmValue);
        
        if (String.isEmpty(parameter)) {
            return '';
        }
        return parameter;
    }
    
    /**
     * 前画面URL存在判定
     */
    public static PageReference isReturnUrl(String prmRetUrl) {
        
        if(String.isEmpty(prmRetUrl)) {
            return new PageReference('/home/home.jsp');
        }
        
        return new PageReference(prmRetUrl);
    }
    
    /**
     * 前画面遷移
     */
    public static PageReference getReturnUrl() {
        String retUrl = CommonUtil.getParameters(CommonConst.PARAM_RETURN_URL);
        return CommonUtil.isReturnUrl(retUrl);
    }
    
    /**
     * 正常系メッセージ表示
     */
    public static void msgInfo(String prmMsg) {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, prmMsg));
    }
    
    /**
     * 異常系メッセージ表示
     */
    public static void msgError(String prmMsg) {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, prmMsg));
    }
    
    /**
     * 警告系メッセージ表示
     */
    public static void msgWarning(String prmMsg) {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, prmMsg));
    }
    
    /**
     * DmlExceptionメッセージ表示
     */
    public static void msgDmlError(Exception e) {
        ApexPages.addMessages(e);
    }
    
    /**
     * Exceptionメッセージ表示
     */
    public static void msgException(Exception e) {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, System.Label.System_Error_Message));
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,e.getMessage()));
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,
            'Line:' + String.valueOf(e.getLineNumber()) + '【' + e.getTypeName() + '】'));
    }
    
    /**
     * Exceptionメッセージを取得
     */
    public static String getExceptionMsg(Exception e, String prmMsg) {
        return prmMsg + '\n' + e.getMessage() + '\n' + 'Line:' + String.valueOf(e.getLineNumber());
    }
    
    /**
     * SingleQuote追加
     */
    public static String toQuery(String prmValue) {
        
        if(String.isEmpty(prmValue)) {
            // 値なし
            return '\'' + '\'';
        }
        // 値あり
        return '\'' + String.escapeSingleQuotes(prmValue) + '\'';
    }
}