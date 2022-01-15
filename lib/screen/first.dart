import 'package:flutter/material.dart';
import 'package:testapp/model/name.dart';
import 'package:testapp/screen/second.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController nameWord = TextEditingController();
  TextEditingController palWord = TextEditingController();

  wordChecker() {
    String pal = palWord.text.replaceAll(' ', '');
    String revPal =
        palWord.text.split('').reversed.join('').replaceAll(' ', '');

    if (pal != '' && revPal != '') {
      if (revPal == pal) {
        return 'True';
      } else {
        return 'False';
      }
    } else {
      return 'Null';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 60, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                child: Image.asset('assets/img/btn_add.png'),
                radius: 80,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: nameWord,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Name',
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: palWord,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Palindrome',
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan.shade900,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        String check = wordChecker();
                        if (check == 'True') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                title: Text(
                                  'Palindrome',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (check == 'False') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                title: Text(
                                  'Not Palindrome',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (check == 'Null') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                title: Text(
                                  'Please insert the word first!',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                  child: const Text('CHECK'),
                ),
                width: double.infinity,
              ),
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan.shade900,
                  ),
                  onPressed: () {
                    name.add(nameWord.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SecondScreen();
                        },
                      ),
                    );
                  },
                  child: const Text('NEXT'),
                ),
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
