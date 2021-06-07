import 'package:flutter/material.dart';
import 'package:mangadex/components/shared/actions/submit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  String? required(String? value) {
    if (value == null || value.isEmpty) return "Username required";

    return null;
  }

  void submit() {
    formKey.currentState?.validate();
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

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 60,
            margin: EdgeInsets.only(top: 30, right: 30),
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
                    Button(),
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
          ),
        ),
      ),
    );
  }
}
