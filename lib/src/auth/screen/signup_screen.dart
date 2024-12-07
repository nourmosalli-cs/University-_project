import 'package:expenses_graduation_project/src/auth/controller/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:expenses_graduation_project/src/auth/screen/signin_screen.dart';
import 'package:expenses_graduation_project/src/auth/widgets/custom_scaffold.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Dedels/screens/Basic.dart';
import '../theme/theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignupKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool agreePersonalData = true;
  bool isSigningUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 10.h,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignupKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // get started text
                      Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 18.0.dm,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 40.0.h),
                      // UserName field with validation
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.near_me),
                          border: const UnderlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          focusColor: Theme.of(context).primaryColor,
                          labelText: "UserName",
                          hintText: "UserName",
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.5),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25.0.h),
                      // Email field with validation
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.person),
                          border: const UnderlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          focusColor: Theme.of(context).primaryColor,
                          labelText: "Email",
                          hintText: "Email",
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.5),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25.0.h),
                      // Password field with validation
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.password),
                          border: const UnderlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          focusColor: Theme.of(context).primaryColor,
                          labelText: "Password",
                          hintText: "Password",
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.5.w),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25.0.h),
                      // Personal data agreement checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: agreePersonalData,
                            onChanged: (bool? value) {
                              setState(() {
                                agreePersonalData = value!;
                              });
                            },
                            activeColor: lightColorScheme.primary,
                          ),
                          Text(
                            'I agree to the processing of ',
                            style: TextStyle(
                              fontSize: 9.0.dm,
                              color: Colors.black45,
                            ),
                          ),
                          Text(
                            'Personal data',
                            style: TextStyle(
                              fontSize: 9.0.dm,
                              fontWeight: FontWeight.bold,
                              color: lightColorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.0.h),
                      // Sign-up button with validation check
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formSignupKey.currentState?.validate() ??
                                false) {
                              if (agreePersonalData) {
                                var authResonse = await supabase.auth.signUp(
                                  password: _passwordController.text,
                                  data: {"full_name": _nameController.text},
                                  email: _emailController.text,
                                );
                                await supabase.from("friends").insert({
                                  "user_id": authResonse.user?.id,
                                  "owner_id": authResonse.user?.id,
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Basic(),
                                  ),
                                );
                              } else {
                                // Show error message if personal data is not agreed upon
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'You must agree to the processing of personal data')),
                                );
                              }
                            }
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 10.0.dm,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0.h),
                      // Sign up divider
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7.dm,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.dm, horizontal: 10.h),
                            child: Text(
                              'Sign up with',
                              style: TextStyle(
                                fontSize: 12.0.dm,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7.dm,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0.h),
                      // Social media logos (optional)
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Add social media login logos here (if needed)
                        ],
                      ),
                      SizedBox(height: 25.0.h),
                      // Navigate to SignIn screen
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontSize: 13.0.dm,
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const SignInScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 13.0.dm,
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signUp() async {
    // setState(() {
    //   isSigningUp = true;
    // });

    // String username = _usernameController.text;
    // String email = _emailController.text;
    // String password = _passwordController.text;

    // User? user = (await _authService.signUpWithEmailAndPassword(
    //     email, password)) as User?;

    // setState(() {
    //   isSigningUp = false;
    // });

    // if (user != null) {
    //   showToast(message: "User is successfully created");
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const Basic(),
    //     ),
    //   );
    // } else {
    //   showToast(message: "Some error happened");
    // }
  }
}
