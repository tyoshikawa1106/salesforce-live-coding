public with sharing class ContactTriggerHandler {

    private ContactTriggerHelper helper = new ContactTriggerHelper();
    private ContactTriggerDao dao = new ContactTriggerDao();

    /**
     * コンストラクタ
     */
    public ContactTriggerHandler() {
        
    }

    /**
     * 取引先責任者件数を更新
     */
    public void doUpdateContactCnt(List<Contact> contacts, Map<Id, Contact> contactMap) {
        // 取引先IDをキーにマップ取得
        Map<Id, List<Contact>> accountIdKeyMap = this.helper.getAccountIdMap(contacts);
        // 取引先ID取得
        Set<Id> accountIds = accountIdKeyMap.KeySet();
        // 取引先IDを条件に取引先情報を取得
        List<Account> accounts = this.dao.getAccountContactCnt(accountIds);
        // 取引先責任者件数に値をセット
        this.helper.setContactCnt(accounts);
        // UPDATE
        List<Database.SaveResult> results = Database.Update(accounts, false);
        // Errorレコード判定
        this.helper.isDmlError(results, accounts, contactMap, accountIdKeyMap);
    }

    /**
     * 取引先責任者件数を更新
     */
    public void doUpdateContactCnt(List<Contact> contacts, Map<Id, Contact> contactNewMap, Map<Id, Contact> contactOldMap) {
        // 取引先IDをキーにマップ取得
        Map<Id, List<Contact>> accountIdKeyMap = this.helper.getAccountIdMap(contacts, contactOldMap);
        // 取引先ID取得
        Set<Id> accountIds = accountIdKeyMap.KeySet();
        // 取引先IDを条件に取引先情報を取得
        List<Account> accounts = this.dao.getAccountContactCnt(accountIds);
        // 取引先責任者件数に値をセット
        this.helper.setContactCnt(accounts);
        // UPDATE
        List<Database.SaveResult> results = Database.Update(accounts, false);
        // Errorレコード判定
        this.helper.isDmlError(results, accounts, contactNewMap, accountIdKeyMap);
    }
}