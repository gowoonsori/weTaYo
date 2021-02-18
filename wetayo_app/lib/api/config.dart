import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlService {
  static final HttpLink httpLink = HttpLink("http://3.35.30.64/wetayo");
  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink as Link, cache: GraphQLCache()));
}

final graphqlService = GraphqlService();
