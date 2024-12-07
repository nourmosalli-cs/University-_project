import 'package:flutter/material.dart';

class TastList extends StatefulWidget {
  const TastList({super.key});

  @override
  State<TastList> createState() => _TastListState();
}

class _TastListState extends State<TastList> {
  // group Function(BuildContext, int) _itemBuilder(List<Test> tasks) {
  //   return (BuildContext context, int index) => group(task: tasks[index]);
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("bdnmvlkd"),
    );
    // return StreamBuilder<List<Test>>(
    //     stream: objectbox.getTest(),
    //     builder: (context, snapshot) {
    //       if (snapshot.data?.isNotEmpty ?? false) {
    //         return ListView.builder(
    //           shrinkWrap: true,
    //           itemCount: snapshot.hasData ? snapshot.data!.length : 0,
    //           itemBuilder: _itemBuilder(snapshot.data ?? []),
    //         );
    //       } else {
    //         return Center(
    //           child: Text("press the + icon to add tasks"),
    //         );
    //       }
    //     });
  }
}
