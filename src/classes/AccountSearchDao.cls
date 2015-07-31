public with sharing class AccountSearchDao {

    /**
     * コンストラクタ
     */
    public AccountSearchDao() {
        
    }

    /**
     * 取引先一覧取得
     */
    public List<Account> getAccounts(Account account) {
        String query = '';
        query += ' SELECT ';
        query += '  Id ';
        query += ' ,Name ';
        query += ' ,AccountNumber ';
        query += ' ,Phone ';
        query += ' ,Fax ';
        query += ' FROM ';
        query += ' Account ';

        String joinQuery = ' WHERE ';
        // 取引名
        if (String.isNotEmpty(account.Name)) {
            query += joinQuery + 'Name LIKE ' + CommonUtil.toQuery(account.Name + '%');
            joinQuery = ' AND ';
        }
        // 取引先番号
        if (String.isNotEmpty(account.AccountNumber)) {
            query += joinQuery + 'AccountNumber = ' + CommonUtil.toQuery(account.AccountNumber);
            joinQuery = ' AND ';
        }

        query += ' ORDER BY Name ASC ';
        query += ' LIMIT 200 ';

        return database.query(query);
    }
}