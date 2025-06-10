import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/components/build_button.dart';
import 'package:netflix/components/build_img.dart';
import 'package:netflix/components/build_text_button.dart';
import 'package:netflix/components/build_text_widget.dart';
import 'package:netflix/data/services/auth_service.dart';
import 'package:netflix/view/bottom/custom_bottom_nav_bar.dart';
import 'package:netflix/view/user/user_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _obscureText = true;

  Future<void> registerWithGoogle() async {
    try {
      AuthService authService = AuthService();

      await authService.registerGoogle();

      final user = authService.getCurUser();

      if (!mounted) return;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => CustomBottomNavBar()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Align(
              alignment: Alignment.center,
              child: Text('Ошибка авторизации с помощью Google'),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Align(
            alignment: Alignment.center,
            child: Text('Ошибка авторизации с помощью Google: $e'),
          ),
        ),
      );
      throw Exception('Register error: $e');
    }
  }

  Future<void> registerWithCredential(
    String name,
    String email,
    String pass,
  ) async {
    try {
      final AuthService authService = AuthService();

      await authService.registerWithEmailAndPassword(email, name, pass);

      final user = authService.getCurUser();

      if (!mounted) return;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => UserScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Align(
              alignment: Alignment.center,
              child: Text("Error with register.Please try again or later."),
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception('Error with register: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BuildImg(assetPath: 'assets/images/logo.png'),
              Column(
                children: [
                  // CREATE ACC TEXT
                  TextBuild(
                    text: 'Create Account',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Form(
                      key: _globalKey,
                      child: Column(
                        children: <Widget>[
                          // EMAIL TEXT FIELD
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                          // LOGIN TEXT FIELD
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: 'Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                          // PASSWORD TEXT FIELD
                          TextField(
                            obscureText: _obscureText,
                            controller: _passController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                                onPressed:
                                    () => setState(() {
                                      _obscureText = !_obscureText;
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // FORM TEXT FIELD
              // SIGN UP BUTTON
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: BuildButton(
                      color: Color(0xffe3562a),
                      text: 'Sign Up',
                      onTap:
                          () => registerWithCredential(
                            _nameController.text,
                            _emailController.text,
                            _passController.text,
                          ),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      textColor: Colors.white,
                    ),
                  ),
                  // NAVIGATE TO LOGIN SCREEN
                  BuildTextButton(
                    text: 'Already have an account?',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => UserScreen()),
                      );
                    },
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    textColor: Color(0xff78746d),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
