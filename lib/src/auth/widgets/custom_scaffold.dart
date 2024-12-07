import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key,
      this.child,
      this.appBar,
      this.includeAppBar = true,
      this.floatingActionButton});
  final Widget? child;
  final PreferredSizeWidget? appBar;
  final bool includeAppBar;
  final Widget? floatingActionButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: includeAppBar
          ? appBar ??
              AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent,
                elevation: 0,
              )
          : appBar,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: child!,
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
