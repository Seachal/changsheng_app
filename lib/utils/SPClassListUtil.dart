class SPClassListUtil{

 static bool spFunIsEmpty(List list){
   if(list==null||list.isEmpty){
     return true;
   }
   return false;
 }
 static bool spFunIsNotEmpty(List list){
   return !spFunIsEmpty(list);
 }
}