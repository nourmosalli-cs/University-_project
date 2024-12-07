import 'package:expenses_graduation_project/src/auth/theme/theme.dart';
import 'package:expenses_graduation_project/src/auth/widgets/custom_scaffold.dart';
import 'package:expenses_graduation_project/src/auth/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // استخدام Supabase لإعادة تعيين كلمة المرور عبر البريد الإلكتروني
  Future<void> resetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      // إظهار رسالة خطأ إذا كان البريد الإلكتروني فارغًا
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your email")),
      );
      return;
    }

    try {
      // إرسال رابط إعادة تعيين كلمة المرور عبر البريد الإلكتروني
      final response =
          await Supabase.instance.client.auth.resetPasswordForEmail(email);
    } catch (e) {
      // معالجة الأخطاء بشكل عام
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Forget Password',
                        style: TextStyle(
                          fontSize: 20.0.dm,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      SizedBox(
                        height: 40.0.h,
                      ),
                      // حقل البريد الإلكتروني
                      TextFieldWidget(
                        hint: 'Email',
                        controller: _emailController,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.email),
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
                      ),
                      SizedBox(
                        height: 25.0.h,
                      ),
                      // زر إعادة تعيين كلمة المرور
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: resetPassword,
                          child: Text(
                            'Reset Password',
                            style: TextStyle(fontSize: 10.0.h),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.0.h,
                      ),
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
}
