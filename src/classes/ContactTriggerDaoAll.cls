public without sharing class ContactTriggerDaoAll {

    /**
     * 取引先責任者の件数を取得
     */
    public static List<Account> getAccountContactCnt(Set<Id> accountIds) {
        return [
            SELECT
                 Id
                ,(SELECT Id FROM Contacts)
            FROM
                Account
            WHERE
                Id IN: accountIds
            ORDER BY Name ASC
        ];
    }
}