class Queries{
 String queryUser(String userName, password){
   return """ 
   query user {
    User(name: "$userName",id: $password ) {
      id
      name
      about
      updatedAt
      avatar {
        medium
      }
  }
}""";
 }
}
//User(name: $userName, id: $password)