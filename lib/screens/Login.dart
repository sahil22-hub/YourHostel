import "package:flutter/material.dart";
import 'package:google_sign_in/google_sign_in.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool _hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _googleSignIn = GoogleSignIn();

  Future _signInGoogle() async {
    await _googleSignIn.signIn();
  }

  Widget _socialLinks(VoidCallback onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        width: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(20, 39, 74, 1.0),
          ),
        ),
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: _size.height * 0.12,
                    width: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Yellow.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FittedBox(
                    child: Row(
                      children: const [
                        Text(
                          'FIND YOUR SECOND',
                          style: TextStyle(
                            color: Color.fromRGBO(125, 193, 66, 1),
                            fontSize: 40,
                            letterSpacing: -3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 14),
                        Text(
                          'HOME',
                          style: TextStyle(
                            color: Color.fromRGBO(243, 236, 34, 1),
                            fontSize: 40,
                            letterSpacing: -3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        autofocus: true,
                        validator: (value) {
                          const pattern =
                              r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                          final regExp = RegExp(pattern);

                          if (value!.isEmpty) {
                            return 'Enter an email';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Enter a valid email';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            fillColor: const Color.fromRGBO(223, 230, 249, 1),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: "Email Address"),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a password";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        obscureText: _hidePassword,
                        decoration: InputDecoration(
                          fillColor: const Color.fromRGBO(223, 230, 249, 1),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => print("pressed Forgot password"),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          // color: const Color.fromRGBO(49, 97, 241, 1),
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(8),
                          // ),
                          // padding: const EdgeInsets.all(15),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(49, 97, 241, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(15.0),
                          ),
                          onPressed: (() {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Login Successful"),
                                ),
                              );
                            }
                          }),
                          child: const Text(
                            "SIGN IN",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  //or continue with design

                  Row(
                    children: const [
                      Expanded(
                        flex: 1,
                        child: Divider(
                          color: Colors.white,
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "or continue with",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Divider(
                          color: Colors.white,
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  //or continue with design
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _socialLinks(() {
                          _signInGoogle();
                        }, AssetImage('assets/images/Google.webp')),
                        _socialLinks(() => print("sign in with facebook"),
                            AssetImage('assets/images/fb.png')),
                        _socialLinks(() => print("sign in with twitter"),
                            AssetImage('assets/images/twitter.jpg')),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  const Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.white,
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        child: TextButton(
                          onPressed: () => print("Sign up"),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color.fromRGBO(125, 193, 66, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
