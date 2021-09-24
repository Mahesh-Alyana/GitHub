import 'package:flutter/material.dart';

import 'package:githubfinal/screen/user_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _usernameController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  void submit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => UserDetailsScreen(
              username: _usernameController.text,
            )));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.4,
                        child: Center(
                          child: Text(
                            "GitHub",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.08,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Image.asset('assets/images/github--v1.png'),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Container(
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius:
                                BorderRadius.circular(size.height * 0.01)),
                        child: TextFormField(
                          controller: _usernameController,
                          style: TextStyle(color: Colors.black),
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please write Something';
                            }
                          },
                          onFieldSubmitted: (ctx) {
                            submit();
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(color: Colors.black),
                              hintText: "Enter Your github Username",
                              labelText: "Username",
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      MaterialButton(
                        minWidth: size.width * 0.8,
                        height: size.height * 0.05,
                        color: Color(0xFF2A82F5),
                        onPressed: () {
                          submit();
                        },
                        child: Text(
                          'Check',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
