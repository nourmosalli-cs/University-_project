import 'package:expenses_graduation_project/src/Dedels/screens/Basic.dart';
import 'package:expenses_graduation_project/src/auth/screen/signin_screen.dart';
import 'package:expenses_graduation_project/src/auth/screen/signup_screen.dart';
import 'package:expenses_graduation_project/src/auth/theme/theme.dart';
import 'package:expenses_graduation_project/src/auth/widgets/SkipLoginButton.dart';
import 'package:expenses_graduation_project/src/auth/widgets/custom_scaffold.dart';
import 'package:expenses_graduation_project/src/auth/widgets/welcome_button.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  void _redirect() async {
    await Future.delayed(Duration.zero);
    final session = Supabase.instance.client.auth.currentSession;
    if (!mounted) return;
    if (session != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Basic(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 40.0,
              ),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'Welcome Back!\n',
                          style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                              '\nEnter personal details to your employee account',
                          style: TextStyle(
                            fontSize: 20,
                            // height: 0,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
            child: Row(
              children: [
                Expanded(
                  child: WelcomeButton(
                    buttonText: 'Sign in',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (e) => const SignInScreen(),
                        ),
                      );
                    },
                    color: Colors.transparent,
                    textColor: Colors.white,
                  ),
                ),
                Expanded(
                  child: WelcomeButton(
                    buttonText: 'Sign up',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (e) => const SignUpScreen(),
                        ),
                      );
                    },
                    color: Colors.white,
                    textColor: lightColorScheme.primary,
                    // textColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
