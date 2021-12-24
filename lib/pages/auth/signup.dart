import 'package:flutter/material.dart';
import 'package:myblog_app/api/auth_api.dart';
import 'package:myblog_app/pages/user/dashboard.dart';
import 'package:myblog_app/utils/contants.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final TextEditingController myEmail = TextEditingController();
  final TextEditingController myName = TextEditingController();
  final TextEditingController myPassword = TextEditingController();

  //form key
  final _formKey = GlobalKey<FormState>();

  //denderedzwa
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 32), child: Text("Signing in ...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Sign up',
              style: TextStyle(
                //color: kSecondaryColor,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: kPrimaryColor.withOpacity(01),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Flexible(
                        child: TextFormField(
                            controller: myName,
                            keyboardType: TextInputType.text,
                            autofocus: true,
                            decoration: InputDecoration(
                              labelText: 'Name',
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Name can not be empty';
                              }
                              /*if (!EmailValidator.validate(val)) {
                                return 'Enter your email address';
                              }*/
                              onSaved:
                                  (val) {
                                setState(() {
                                  myName.text = val;
                                });
                              };
                            }),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Flexible(
                        child: TextFormField(
                            controller: myEmail,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: true,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Email can not be empty';
                              }
                              /*if (!EmailValidator.validate(val)) {
                                return 'Enter your email address';
                              }*/
                              onSaved:
                                  (val) {
                                setState(() {
                                  myEmail.text = val;
                                });
                              };
                            }),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Flexible(
                        child: TextFormField(
                            controller: myPassword,
                            //keyboardType: TextInputType.,
                            //autofocus: true,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'password can not be empty';
                              }
                              onSaved:
                                  (val) {
                                setState(() {
                                  myPassword.text = val;
                                });
                              };
                            }),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        color: kPrimaryColor,
                        width: 300,
                        child: TextButton(
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          onPressed: () {
                            setState(() {
                              if ((myEmail.text == "") &&
                                  (myPassword.text == "")) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: new Text("ACCESS DENIED!!!"),
                                        content: new Text(
                                            "Missing Information!!!\nPassword, Email or Name can not be blank."),
                                        actions: <Widget>[
                                          new TextButton(
                                            child: new Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              //_sendAnalyticsEvent(
                                              //    'Password or Username was empty');
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                final form = _formKey.currentState;
                                if (form!.validate()) {
                                  form.save();
                                  CircularProgressIndicator();
                                  showLoaderDialog(context);
                                  //iniSharedPref();

                                  signUpUser(myEmail.text, myName.text, myPassword.text)
                                      .then((value) {
                                    if (value == 201) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => Dashboard()),
                                            (Route<dynamic> route) => false,
                                      );
                                    } else {
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                              new Text("ACCESS DENIED!!!"),
                                              content: new Text(
                                                  "Password or Email not found."),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  child: new Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  });
                                }
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
