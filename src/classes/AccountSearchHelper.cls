public with sharing class AccountSearchHelper {

    /**
     * コンストラクタ
     */
    public AccountSearchHelper() {
        
    }

    /**
     * リスト件数判定
     */
    public Boolean isEmptyList(Integer listSize, String message) {
        if (listSize == 0) {
            CommonUtil.msgWarning(message);
            return true;
        }

        return false;
    }
}