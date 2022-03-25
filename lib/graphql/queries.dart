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
 String mutationLogin(String loginId ,String password){
   return """ mutation login{
  createSession(input: { sessionClass: ACCOUNT
  loginId: "$loginId"
  password: "$password"}){
    clientMutationId
    errors{message}
    session{
      token
      userId
    }
  }
}""";
 }
 String queryBulletins(){
   return"""query bulletins{
  bulletin(id: "QnVsbGV0aW4tOTE="){
    shop{
      name
    }
    title
    content
    user{
      email
      company{
        address1
        buildings{
          nodes{
            city{
              nameKana
              name
            }
          }
        }
      }
    }
  }
} """;
 }
 String  mutationDestroySession(){
   return """
   mutation destroy{
  destroySession(input: { }) {
    clientMutationId
    session {
      enableAppLogin
      firebaseToken
      isManager
      proxyAdminToken
      requisiteUpdatingPassword
      token
      tosAgreedAt
      tosFreedialAgreedAt
      userFirebaseId
      userId
    }
  }
}""";

 }
}
