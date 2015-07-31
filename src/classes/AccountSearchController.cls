public with sharing class AccountSearchController {

    private AccountSearchHelper helper = new AccountSearchHelper();
    private AccountSearchDao dao = new AccountSearchDao();

    public Account account {get; set;}
    public List<Account> accounts {get; set;}

    /**
     * コンストラクタ
     */
    public AccountSearchController() {
        try {
            this.account = new Account();
            this.accounts = new List<Account>();
        } catch(Exception e) {
            CommonUtil.msgException(e);
            return;
        }  
    }

    /**
     * 検索ボタン
     */
    public void doSearch() {
        try {
            // 取引先一覧取得
            this.accounts = this.dao.getAccounts(this.account);
            // リスト判定
            if (this.helper.isEmptyList(this.accounts.size(), System.Label.Not_Records)) return;
        } catch(Exception e) {
            CommonUtil.msgException(e);
            return;
        }  
    }
}