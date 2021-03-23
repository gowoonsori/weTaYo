class Mutations {
  static String loginMutation = """
    mutation login(\$email : String!, \$password: String!){
      login(email: \$email, password: \$password) {
        token
      }
    }
  """;
}
