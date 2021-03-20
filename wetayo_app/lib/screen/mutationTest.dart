import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MutationTest extends StatefulWidget {
  _MutationTest createState() => _MutationTest();
}

class _MutationTest extends State<MutationTest> {
  int _data = 123456;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Mutation(
              options: MutationOptions(
                document: gql("""mutation{
    createRide(stationId: $_data routeId: $_data){
        stationId
        routeId
    }
}"""),
                update: (GraphQLDataProxy cache, QueryResult result) {
                  return cache;
                },
                onCompleted: (dynamic resultData) =>
                    _simpleAlert(context, 'Good Test'),
              ),
              builder: (
                RunMutation runMutation,
                QueryResult result,
              ) {
                return RaisedButton(
                  child: Text('Test1'),
                  onPressed: () => runMutation({
                    'stationId': _data,
                    'routeId': _data,
                  }),
                );
              },
            ),
            Container(
              child: RaisedButton(
                child: Text('Test'),
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('탑승 예약'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('Test'),
                                Text('$_data번 버스를 탑승 하시겠습니까?')
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('확인'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('취소'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _simpleAlert(BuildContext context, String text) => showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: <Widget>[
            SimpleDialogOption(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
