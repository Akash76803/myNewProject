public class BookAuthor_handler {

    public static void beforeDelete(map<id, Book_Author__c> oldlist){
       list<Book__c>blist = new list<Book__c>(); 
        for(Book__c obj:[select id, Book_Author__r.id, Book_Author_Id__c from Book__c where Book_Author__r.id in: oldlist.keySet() ]){
            
            obj.Book_Author_Id__c = obj.Book_Author__c ;
            blist.add(obj);
        }
        update blist;
    }

    public static void AfterDelete(map<id, Book_Author__c> oldlist){
     list<Book__c>blists = [select id,name from Book__c where Book_Author_Id__c in: oldlist.keySet() ];
        delete blists;
    }
}