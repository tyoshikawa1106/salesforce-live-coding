trigger ContactTrigger on Contact (after insert, after delete, after undelete, after update) {

    ContactTriggerHandler handler = new ContactTriggerHandler();

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            // 取引先責任者件数を更新
            handler.doUpdateContactCnt(Trigger.new, Trigger.newMap);
        } else if (Trigger.isDelete){
            // 取引先責任者件数を更新
            handler.doUpdateContactCnt(Trigger.old, Trigger.oldMap);
        } else if (Trigger.isUndelete) {
            // 取引先責任者件数を更新
            handler.doUpdateContactCnt(Trigger.new, Trigger.newMap);
        } else if (Trigger.isUpdate) {
            // 取引先責任者件数を更新
            handler.doUpdateContactCnt(Trigger.new, Trigger.newMap, Trigger.oldMap);
        }
    }
}