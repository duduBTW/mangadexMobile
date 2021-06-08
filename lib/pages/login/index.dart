import 'package:flutter/material.dart';
import 'package:mangadex/components/shared/actions/submit.dart';
import 'package:mangadex/services/http.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  MangadexService http = new MangadexService();

  String? required(String? value) {
    if (value == null || value.isEmpty) return "Field required";

    return null;
  }

  void submit() async {
    var valid = formKey.currentState?.validate();

    if (valid != null && valid) {
      setState(() {
        loading = true;
      });

      http.post("/auth/login", {"username": "", "password": ""}).then(
          (response) {
        print(response.data.toString());
        if (response.statusCode == 200) {
          //Success
        }

        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var decorator = InputDecoration(
      filled: true,
      fillColor: Theme.of(context).backgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.only(left: 30, bottom: 10, top: 10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.5))),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.5))),
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    );

    return Container(
      height: MediaQuery.of(context).size.height - 60,
      margin: EdgeInsets.only(right: 30),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
      child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, top: 30),
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Spacer(),
              Text("Username"),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                cursorColor: Colors.black,
                decoration: decorator,
                validator: required,
              ),
              SizedBox(
                height: 30,
              ),
              Text("Passworld"),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                cursorColor: Colors.black,
                decoration: decorator,
                validator: required,
                obscureText: true,
              ),
              Spacer(),
              Button(submit, loading),
              Spacer(),
              // Container(
              //   width: double.infinity,
              //   padding: const EdgeInsets.only(bottom: 60, top: 30),
              //   child: Text(
              //     "Forgot your passworld?",
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //         color: Theme.of(context).primaryColor,
              //         letterSpacing: 1,
              //         fontWeight: FontWeight.w700),
              //   ),
              // ),
            ],
          )),
    );
  }
}
