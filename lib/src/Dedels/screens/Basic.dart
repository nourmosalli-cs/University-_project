import 'package:expenses_graduation_project/src/Dedels/widget/BottomNavigationBar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'drawer_screen.dart';

class Basic extends StatelessWidget {
  const Basic({super.key});

  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
      angle: 0,
      mainScreenScale: 0.1,
      borderRadius: 40,
      menuScreen: DrawerScreenPage(),
      mainScreen: DivideScreen(),
    );
  }
}
