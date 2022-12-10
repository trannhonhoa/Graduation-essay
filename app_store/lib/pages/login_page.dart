import 'package:ecomshop/api/api_service.dart';
import 'package:ecomshop/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsynCallProcess = false;
  String? password;
  String? email;
  bool hidePassword = true;
  bool isRemember = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: ProgressHUD(
        inAsyncCall: isAsynCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: Form(
          key: globalKey,
          child: _loginUI(context),
        ),
      ),
    ));
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo.jpg",
                    fit: BoxFit.contain,
                    width: 150,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Grocery Green",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
            const Center(
              child: Text(
                "Sign In",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FormHelper.inputFieldWidget(context, "email", "Email",
                (onValidate) {
              if (onValidate.isEmpty) {
                return "* Required";
              }
              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(onValidate);
              if (!emailValid) {
                return "Invalid Email";
              }
              return null;
            }, (onSaved) {
              email = onSaved.toString().trim();
            },
                prefixIcon: const Icon(Icons.email_outlined),
                showPrefixIcon: true,
                borderRadius: 10,
                contentPadding: 15,
                fontSize: 14,
                prefixIconPaddingLeft: 10,
                borderColor: Colors.green,
                textColor: Colors.black,
                prefixIconColor: Colors.black,
                hintColor: Colors.black.withOpacity(0.6),
                backgroundColor: Colors.grey.shade100,
                borderFocusColor: Colors.green),
            const SizedBox(
              height: 10,
            ),
            FormHelper.inputFieldWidget(
                context,
                "passsword",
                "Password",
                (onValidate) {
                  if (onValidate.isEmpty) {
                    return "* Required";
                  }

                  return null;
                },
                (onSaved) {
                  password = onSaved.toString().trim();
                },
                prefixIcon: const Icon(Icons.password_outlined),
                showPrefixIcon: true,
                borderRadius: 10,
                contentPadding: 15,
                fontSize: 14,
                prefixIconPaddingLeft: 10,
                borderColor: Colors.green,
                textColor: Colors.black,
                prefixIconColor: Colors.black,
                hintColor: Colors.black.withOpacity(0.6),
                backgroundColor: Colors.grey.shade100,
                borderFocusColor: Colors.green,
                obscureText: hidePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility),
                  color: Colors.greenAccent.withOpacity(0.4),
                ),
                onChange: (val) {
                  password = val;
                }),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: FormHelper.submitButton("Sign In", () {
              if (validateSave()) {
                setState(() {
                  isAsynCallProcess = true;
                });
                APIService.loginUser(email!, password!).then((res) => {
                      setState(() => {isAsynCallProcess = false}),
                      if (res)
                        {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Login completed successfully",
                              "Ok", () {
                            Navigator.of(context).pop();
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/home', (route) => false);
                          })
                        }
                      else
                        {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Invalid Email/Password",
                              "Ok", () {
                            Navigator.of(context).pop();
                          })
                        }
                    });
              }
            },
                    btnColor: Colors.green,
                    borderColor: Colors.black,
                    borderRadius: 20)),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: RichText(
                  text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: [
                    const TextSpan(text: "Haven't an account?"),
                    TextSpan(
                        text: " register",
                        style: const TextStyle(color: Colors.green),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/register', (route) => false);
                          })
                  ])),
            )
          ]),
    );
  }

  bool validateSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
