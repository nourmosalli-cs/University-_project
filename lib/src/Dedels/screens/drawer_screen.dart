import 'dart:typed_data';
import 'package:expenses_graduation_project/src/Dedels/screens/mytabbarpage.dart';
import 'package:expenses_graduation_project/src/auth/screen/signup_screen.dart';
import 'package:expenses_graduation_project/src/auth/screen/welcome_screen.dart';
import 'package:expenses_graduation_project/src/core/uitils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DrawerScreenPage extends StatefulWidget {
  const DrawerScreenPage({super.key});

  @override
  State<DrawerScreenPage> createState() => _DrawerScreenPageState();
}

class _DrawerScreenPageState extends State<DrawerScreenPage> {
  final currentUser = Supabase.instance.client.auth.currentUser;
  Uint8List? _image;
  void selectImage() async {
    // Uint8List img = await pickImage(ImageSource.gallery);

    // setState(() {
    //   _image = img;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
            onTap: () => ZoomDrawer.of(context)!.close(),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.dm,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          GestureDetector(
            onTap: () => selectImage(),
            child: Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 54,
                        backgroundImage:
                            _image != null ? MemoryImage(_image!) : null,
                        child: _image == null
                            ? const Icon(
                                Icons.person,
                                color: Colors.white,
                              )
                            : null,
                      )
                    : const CircleAvatar(
                        radius: 49,
                        backgroundImage: AssetImage('assets/images/bg6.png'),
                      ),
                // Positioned(
                //   child: IconButton(
                //     onPressed: () => selectImage(),
                //     icon: Icon(Icons.add_a_photo),
                //   ),
                //   bottom: -10,
                //   left: 65,
                // )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Center(
              child: Text(
            currentUser!.email!,
            style: TextStyle(
              fontSize: 10.h,
              color: Colors.white,
            ),
          )),
          SizedBox(
            height: 30.h,
          ),
          Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
                title: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (e) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 12.dm,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 11.dm,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  // await Supabase.instance.client.auth.signOut();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyTabBarPage(),
                  ));
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Setting',
                    style: TextStyle(
                      fontSize: 12.dm,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Supabase.instance.client.auth.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ));
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 12.dm,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
