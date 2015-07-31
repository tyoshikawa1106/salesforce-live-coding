public with sharing class ContactTriggerDao {

    /**
     * コンストラクタ
     */
    public ContactTriggerDao() {
        
    }

    /**
     * 取引先責任者の件数を取得
     */
    public List<Account> getAccountContactCnt(Set<Id> accountIds) {
        return ContactTriggerDaoAll.getAccountContactCnt(accountIds);
    }
}