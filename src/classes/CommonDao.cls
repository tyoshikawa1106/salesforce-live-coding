public with sharing class CommonDao {
    
    /**
     * ログインユーザ取得
     */
    public static User getUser() {
        return [
            SELECT
                 Id
                ,Name
                ,LanguageLocaleKey
                ,LocaleSidKey
            FROM
                User
            WHERE
                Id =: UserInfo.getUserId()
            LIMIT 1
        ];
    }
}