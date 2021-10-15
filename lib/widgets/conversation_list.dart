import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yam/widgets/conversation_list_item.dart';
import 'package:http/http.dart' as http;

import 'models/chat_users_model.dart';

class ConversationList extends StatefulWidget {
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  List<ChatUsers> chatUsers = [];

  void fetchUserList() async {
    final response =
        await http.get(Uri.parse('http://192.168.43.144:8080/api/user/list'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //return Album.fromJson(jsonDecode(response.body));

      var json = jsonDecode(response.body);
      print(json);

      var userList = json['userInfos'] as List;
      userList.forEach((element) {});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    chatUsers.addAll([
      ChatUsers(
        id: 'id001',
        name: "Илья Годяев",
        messageText: "Ага",
        imageURL:
            "https://sun4-11.userapi.com/s/v1/if1/zuF1UsBOMZ5ApE1VB9EJFjWbZq7RXChRw_tXomSRB9DiH2tPYyZeqDUhhBmkHC-tO-UpaH2m.jpg?size=100x100&quality=96&crop=0,8,1010,1010&ava=1",
        time: "Yesterday",
      ),
      ChatUsers(
        id: 'id002',
        name: "Илья Симоненко",
        messageText: "Не",
        imageURL:
            "https://sun4-15.userapi.com/s/v1/if1/zZVazCrWYbV7PizVFpAYPTTXIbgqdDp9-7FE43BR6giGZeeGX4CHA_ioA71Bx8MN9Nab8ln5.jpg?size=100x100&quality=96&crop=285,184,1182,1182&ava=1",
        time: "Yesterday",
      ),
      ChatUsers(
        id: 'id003',
        name: "Раимбек Рахимбеков",
        messageText: "..",
        imageURL:
            "https://sun4-15.userapi.com/s/v1/ig2/gRyj33y7Ypu9s4qtQDOidCML_oAm1EPS7JN0XAHP0HO0Prtd1jtE-exlAT4dIB0ITWmSxcuMHxI_XRYrcLJYL3Ld.jpg?size=200x200&quality=96&crop=233,1,749,749&ava=1",
        time: "Yesterday",
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var physics = const BouncingScrollPhysics()
        .applyTo(const AlwaysScrollableScrollPhysics());

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
      key: scaffoldKey,
      body: RefreshIndicator(
        onRefresh: () {
          print('onRefresh');

          return Future.delayed(const Duration(milliseconds: 500), () {
            print('The function that changees state');

            setState(() {});

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                'updated',
                textAlign: TextAlign.center,
              ),
              duration: Duration(seconds: 1),
            ));
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: physics,
              itemBuilder: (context, index) {
                return ConversationListItem(
                  id: chatUsers[index].id,
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
