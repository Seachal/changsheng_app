class CSClassListUtil{

 static bool csMethodIsEmpty(List list){
   if(list==null||list.isEmpty){
     return true;
   }
   return false;
 }
 static bool csMethodIsNotEmpty(List list){
   return !csMethodIsEmpty(list);
 }
}