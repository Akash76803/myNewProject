trigger BookAuthor on Book_Author__c (before delete, after delete) {
if(trigger.isDelete)
    {
        if(trigger.isBefore)
        {
            BookAuthor_handler.beforeDelete(trigger.oldmap);
             
        }
        if(trigger.isAfter)
        {
          BookAuthor_handler.AfterDelete(trigger.oldmap);
        }
    }

}