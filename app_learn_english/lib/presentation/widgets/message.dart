import 'package:app_learn_english/states/current_user_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class messages extends StatefulWidget {
  String email;
  messages({required this.email});
  @override
  _messagesState createState() => _messagesState(email: email);
}

class _messagesState extends State<messages> {
  String email;
  _messagesState({required this.email});

  Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection('Messages')
      .orderBy('time')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("something is wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot qs = snapshot.data!.docs[index];
            Timestamp t = qs['time'];
            DateTime d = t.toDate();
            print(d.toString());
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: email == qs['email']
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  qs['type'] == "text" ?
                  SizedBox(
                    width: 300,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: email == qs['email'] ? Colors.purple : Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        qs['email'],
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 200,
                            child: Text(
                              qs['message'],
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            d.hour.toString() + ":" + d.minute.toString(),
                          )
                        ],
                      ),
                    ),
                  ) : Container(
                    height: 250,
                    width: 200,
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    alignment: qs['email'] == email ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      height: 250,
                      width: 200,
                      alignment: qs['message'] != "" ? null : Alignment.center,
                      child: qs['message'] != "" ? (
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(CurrentUserState.username, style: TextStyle(fontSize: 14, color: Colors.grey),),
                                  Text(d.hour.toString() + ":" + d.minute.toString(), style: TextStyle(color: Colors.grey),)
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(left: 8, right: 8),
                              child: Image.network(
                                qs['message'],
                                height: 232,
                                fit: BoxFit.contain,
                              ),
                              )
                            ],
                          )
                      ) : CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}