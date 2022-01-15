import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:testapp/screen/second.dart';
import 'package:testapp/model/name.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  bool stateCon = false;

  RefreshController ref = RefreshController();

  Future loadData() async {
    stateCon = true;
    ref.loadComplete();
    setState(() {});
  }

  Future refreshData() async {
    ref.refreshCompleted();
    setState(() {});
  }

  final String apiUrlOne = "https://reqres.in/api/users";

  Future fecthAPI1() async {
    var result = await http.get(Uri.parse(apiUrlOne));
    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Third Screen',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SecondScreen();
                },
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1000,
          child: SmartRefresher(
            scrollDirection: Axis.vertical,
            controller: ref,
            onLoading: loadData,
            enablePullDown: false,
            enablePullUp: true,
            child: Column(
              children: [
                FutureBuilder(
                  future: fecthAPI1(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(10),
                        primary: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(snapshot.data[index]['avatar']),
                            ),
                            title: Text(snapshot.data[index]['first_name'] +
                                " " +
                                snapshot.data[index]['last_name']),
                            subtitle: Text(snapshot.data[index]['email']),
                            onTap: () {
                              selectedName.add(snapshot.data[index]
                                      ['first_name'] +
                                  ' ' +
                                  snapshot.data[index]['last_name']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const SecondScreen();
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                stateCon ? secAPI() : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget secAPI() {
  const String apiUrlTwo = "https://reqres.in/api/users?page=2";

  Future fecthAPI2() async {
    var result = await http.get(Uri.parse(apiUrlTwo));
    return json.decode(result.body)['data'];
  }

  return FutureBuilder(
    future: fecthAPI2(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          primary: false,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(snapshot.data[index]['avatar']),
              ),
              title: Text(snapshot.data[index]['first_name'] +
                  " " +
                  snapshot.data[index]['last_name']),
              subtitle: Text(snapshot.data[index]['email']),
              onTap: () {
                selectedName.add(snapshot.data[index]['first_name'] +
                    ' ' +
                    snapshot.data[index]['last_name']);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SecondScreen();
                    },
                  ),
                );
              },
            );
          },
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
  );
}
