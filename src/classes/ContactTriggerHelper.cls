public with sharing class ContactTriggerHelper {

    /**
     * コンストラクタ
     */
    public ContactTriggerHelper() {
        
    }

    /**
     * 取引先IDをキーにマップを取得
     */
    public Map<Id, List<Contact>> getAccountIdMap(List<Contact> contacts) {
        Map<Id, List<Contact>> accountIdKeyMap = new Map<Id, List<Contact>>();
        for (Contact contact : contacts) {
            if (String.isNotEmpty(contact.AccountId)) {
                // accountIdKeyMapにセットするContactListを取得
                List<Contact> cList = this.getContactListByAccountIdKeyMap(contact, accountIdKeyMap);
                // Add Map
                accountIdKeyMap.put(contact.AccountId, cList);
            }
        }

        return accountIdKeyMap;
    }

    /**
     * 取引先IDをキーにマップを取得
     */
    public Map<Id, List<Contact>> getAccountIdMap(List<Contact> contacts, Map<Id, Contact> contactOldMap) {
        Map<Id, List<Contact>> accountIdKeyMap = new Map<Id, List<Contact>>();
        for (Contact contact : contacts) {
            // 変更前の取引先ID
            if (contactOldMap.containsKey(contact.Id)) {
                Id oldAccountId = contactOldMap.get(contact.Id).AccountId;
                Contact oldContact = contactOldMap.get(contact.Id);
                // 取引先IDが変更されたか
                if (contact.AccountId != oldAccountId) {
                    // [New Contact] accountIdKeyMapにセットするContactListを取得
                    List<Contact> contactNewList = this.getContactListByAccountIdKeyMap(contact, accountIdKeyMap);
                    // Add Map
                    accountIdKeyMap.put(contact.AccountId, contactNewList);
                    
                    // [Old Contact] accountIdKeyMapにセットするContactListを取得
                    List<Contact> contactOldList = this.getContactListByAccountIdKeyMap(oldContact, accountIdKeyMap);
                    // Add Map
                    accountIdKeyMap.put(oldAccountId, contactOldList);
                }
            }
        }

        return accountIdKeyMap;
    }

    /**
     * accountIdKeyMapにセットするContactListを取得
     */
    private List<Contact> getContactListByAccountIdKeyMap(Contact contact, Map<Id, List<Contact>> accountIdKeyMap) {
        List<Contact> cList = new List<Contact>();
        if (accountIdKeyMap.containsKey(contact.AccountId)) {
            cList = accountIdKeyMap.get(contact.AccountId);
        }
        // Add List
        cList.add(contact);

        return cList;
    }

    /**
     * 取引先責任者件数をセット
     */
    public void setContactCnt(List<Account> accounts) {
        for (Account account : accounts) {
            account.ContactCnt__c = account.Contacts.size();
        }
    }

    /**
     * DMLエラー判定
     */
    public void isDmlError(List<Database.Saveresult> results, List<Account> accounts, Map<Id, Contact> contactMap, Map<Id, List<Contact>> accountIdKeyMap) {
        // Errorレコード判定
        Integer i = 0;
        for (Database.SaveResult sr : results) {
            if(!sr.isSuccess()) {
                Database.Error err = sr.getErrors()[0];
                if (accountIdKeyMap.containsKey(accounts[i].Id)) {
                    List<Contact> errorContacts = accountIdKeyMap.get(accounts[i].Id);
                    // Error Contact Add Error
                    for (Contact errorContact : errorContacts) {
                        contactMap.get(errorContact.Id).addError(
                            err.getMessage()
                        );
                    }
                }
            }
            i++;
        }
    }
}