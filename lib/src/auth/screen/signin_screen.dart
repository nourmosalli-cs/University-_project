// import 'package:expenses_graduation_project/src/Dedels/screens/Basic.dart';
// import 'package:expenses_graduation_project/src/auth/controller/firebase_auth_services.dart';
// import 'package:expenses_graduation_project/src/auth/screen/forget_passsword_screen.dart';
// import 'package:expenses_graduation_project/src/auth/screen/signup_screen.dart';
// import 'package:expenses_graduation_project/src/auth/widgets/custom_scaffold.dart';
// import 'package:expenses_graduation_project/src/auth/widgets/text_field_widget.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../theme/theme.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final _formSignInKey = GlobalKey<FormState>();
//   bool rememberPassword = true;
//   bool _isSigning = false;
//   final FirebaseAuthService _auth = FirebaseAuthService();
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       child: Column(
//         children: [
//           Expanded(
//             flex: 1,
//             child: SizedBox(
//               height: 10.h,
//             ),
//           ),
//           Expanded(
//             flex: 7,
//             child: Container(
//               padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40.0.dm),
//                   topRight: Radius.circular(40.0.dm),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _formSignInKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Welcome back',
//                         style: TextStyle(
//                           fontSize: 20.0.dm,
//                           fontWeight: FontWeight.w900,
//                           color: lightColorScheme.primary,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 40.0.h,
//                       ),
//                       TextFieldWidget(
//                         hint: 'Email',
//                         controller: _emailController,
//                         decoration: InputDecoration(
//                             icon: const Icon(Icons.person),
//                             border: const UnderlineInputBorder(),
//                             floatingLabelBehavior: FloatingLabelBehavior.always,
//                             // focusedBorder: OutlineInputBorder(),
//                             focusColor: Theme.of(context).primaryColor,
//                             labelText: "Email",
//                             hintText: "Email",
//                             errorBorder: const UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.red)),
//                             focusedErrorBorder: const UnderlineInputBorder(
//                                 borderSide:
//                                     BorderSide(color: Colors.red, width: 2.5))),
//                       ),
//                       SizedBox(
//                         height: 25.0.h,
//                       ),
//                       TextFieldWidget(
//                         hint: 'Password',
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                             icon: const Icon(Icons.password),
//                             border: const UnderlineInputBorder(),
//                             floatingLabelBehavior: FloatingLabelBehavior.always,
//                             // focusedBorder: OutlineInputBorder(),
//                             focusColor: Theme.of(context).primaryColor,
//                             labelText: "Password",
//                             hintText: "Password",
//                             errorBorder: const UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.red)),
//                             focusedErrorBorder: const UnderlineInputBorder(
//                                 borderSide:
//                                     BorderSide(color: Colors.red, width: 2.5))),
//                       ),

//                       SizedBox(
//                         height: 25.0.h,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Checkbox(
//                                 value: rememberPassword,
//                                 onChanged: (bool? value) {
//                                   setState(() {
//                                     rememberPassword = value!;
//                                   });
//                                 },
//                                 activeColor: lightColorScheme.primary,
//                               ),
//                               Text(
//                                 'Remember me',
//                                 style: TextStyle(
//                                   fontSize: 10.0.dm,
//                                   color: Colors.black45,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) {
//                                 return const ForgetPasswordScreen();
//                               }));
//                             },
//                             child: Text(
//                               'Forget password?',
//                               style: TextStyle(
//                                 fontSize: 10.0.dm,
//                                 fontWeight: FontWeight.bold,
//                                 color: lightColorScheme.primary,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 25.0.h,
//                       ),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: _signIn,
//                           // if (_formSignInKey.currentState!.validate() &&
//                           //     rememberPassword) {
//                           //   ScaffoldMessenger.of(context).showSnackBar(
//                           //     const SnackBar(
//                           //       content: Text('Processing Data'),
//                           //     ),
//                           //   );
//                           //   _signIn;
//                           // } else if (!rememberPassword) {
//                           //   ScaffoldMessenger.of(context).showSnackBar(
//                           //     const SnackBar(
//                           //         content: Text(
//                           //             'Please agree to the processing of personal data')),
//                           //   );
//                           // }

//                           child: Text(
//                             'Sign in',
//                             style: TextStyle(
//                               fontSize: 10.0.dm,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 25.0.h,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: Divider(
//                               thickness: 0.7.dm,
//                               color: Colors.grey.withOpacity(0.5),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               vertical: 0.sp,
//                               horizontal: 10.sp,
//                             ),
//                             child: Text(
//                               'Sign up with',
//                               style: TextStyle(
//                                 fontSize: 12.0.dm,
//                                 color: Colors.black45,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Divider(
//                               thickness: 0.7,
//                               color: Colors.grey.withOpacity(0.5),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 25.0.h,
//                       ),
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           // Logo(Logos.facebook_f),
//                           // Logo(Logos.twitter),
//                           // Logo(Logos.google),
//                           // Logo(Logos.apple),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 25.0.h,
//                       ),
//                       // don't have an account
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Don\'t have an account? ',
//                             style: TextStyle(
//                               fontSize: 13.0.dm,
//                               color: Colors.black45,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (e) => const SignUpScreen(),
//                                 ),
//                               );
//                             },
//                             child: Text(
//                               'Sign up',
//                               style: TextStyle(
//                                 fontSize: 13.0.dm,
//                                 fontWeight: FontWeight.bold,
//                                 color: lightColorScheme.primary,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20.0.h,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _signIn() async {
//     setState(() {
//       _isSigning = true;
//     });

//     String email = _emailController.text;
//     String password = _passwordController.text;

//     User? user = await _auth.signInWithEmailAndPassword(email, password);

//     setState(() {
//       _isSigning = false;
//     });

//     if (user != null) {
//       showToast(message: "User is successfully signed in");
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (e) => const Basic(),
//         ),
//       );
//     } else {
//       showToast(message: "some error occured");
//     }
//   }
// }
import 'dart:async';

import 'package:expenses_graduation_project/src/auth/controller/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:expenses_graduation_project/src/Dedels/screens/Basic.dart';
import 'package:expenses_graduation_project/src/auth/screen/forget_passsword_screen.dart';
import 'package:expenses_graduation_project/src/auth/screen/signup_screen.dart';
import 'package:expenses_graduation_project/src/auth/widgets/custom_scaffold.dart';
import 'package:expenses_graduation_project/src/auth/widgets/text_field_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../theme/theme.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;
  bool _isSigning = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // استخدام الخدمة
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen(
      (event) {
        final session = event.session;
        if (session != null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const Basic(),
          ));
        }
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authSubscription.cancel();
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0.dm),
                  topRight: Radius.circular(40.0.dm),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome back',
                        style: TextStyle(
                          fontSize: 20.0.dm,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 40.0.h),
                      _buildTextField(
                        controller: _emailController,
                        hint: 'Email',
                        icon: Icons.person,
                        label: 'Email',
                      ),
                      SizedBox(height: 25.0.h),
                      _buildTextField(
                        controller: _passwordController,
                        hint: 'Password',
                        icon: Icons.password,
                        label: 'Password',
                        obscureText: true,
                      ),
                      SizedBox(height: 25.0.h),
                      _buildRememberMeRow(),
                      SizedBox(height: 25.0.h),
                      _buildSignInButton(),
                      SizedBox(height: 25.0.h),
                      _buildSignUpRow(),
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

  // بناء TextField مشترك
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required String label,
    bool obscureText = false,
  }) {
    return TextFieldWidget(
      hint: hint,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        icon: Icon(icon),
        border: const UnderlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusColor: Theme.of(context).primaryColor,
        labelText: label,
        hintText: hint,
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.5),
        ),
      ),
    );
  }

  // بناء زر الدخول
  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _signIn,
        child: Text(
          'Sign in',
          style: TextStyle(fontSize: 10.0.dm),
        ),
      ),
    );
  }

  // بناء Row لتذكر كلمة المرور
  Widget _buildRememberMeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberPassword,
              onChanged: (bool? value) {
                setState(() {
                  rememberPassword = value!;
                });
              },
              activeColor: lightColorScheme.primary,
            ),
            Text(
              'Remember me',
              style: TextStyle(
                fontSize: 10.0.dm,
                color: Colors.black45,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ForgetPasswordScreen();
            }));
          },
          child: Text(
            'Forget password?',
            style: TextStyle(
              fontSize: 10.0.dm,
              fontWeight: FontWeight.bold,
              color: lightColorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  // بناء Row للتسجيل
  Widget _buildSignUpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
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
                builder: (e) => const SignUpScreen(),
              ),
            );
          },
          child: Text(
            'Sign up',
            style: TextStyle(
              fontSize: 13.0.dm,
              fontWeight: FontWeight.bold,
              color: lightColorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  // منطق الدخول
  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;
    AuthResponse? response;
    try {
      response = await _authService.signIn(email, password);
    } on AuthException catch (e) {
      showToast(message: e.message);
    }
    setState(() {
      _isSigning = false;
    });

    if (response != null) {
      showToast(message: "User is successfully signed in");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (e) => const Basic(),
        ),
      );
    }
  }
}
