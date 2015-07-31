public with sharing class CommonTester {
    
    /**
     * テスト実行ユーザ取得
     */
    public static User getLoginUser() {
        return new User(Id = UserInfo.getUserId());
    }

    /**
     * テスト実行ページ取得
     */
    public static PageReference getPageReference() {
        return new PageReference('PageReference');
    }
    
    /**
     * 取引先
     */
    public static Account createAccount(Boolean isInsert) {
        
        Account account = new Account(       
             Name = 'Account Name'
        );
        
        if (isInsert) {
            insert account;
        }
        
        return account;
    }

    /**
     * 取引先責任者
     */
    public static Contact createContact(Account account, Boolean isInsert) {
        
        Contact contact = new Contact(
             AccountId = account.Id
            ,LastName = 'LastName'
            ,FirstName = 'FirstName'
        );
        
        if (isInsert) {
            insert contact;
        }
        
        return contact;
    }
}