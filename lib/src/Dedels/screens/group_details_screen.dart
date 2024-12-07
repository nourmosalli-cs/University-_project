import 'package:expenses_graduation_project/src/Dedels/controller/group_controller.dart';
import 'package:expenses_graduation_project/src/Dedels/model/group_model.dart';
import 'package:expenses_graduation_project/src/Dedels/screens/CreateGroupPage.dart';
import 'package:expenses_graduation_project/src/auth/theme/theme.dart';
import 'package:expenses_graduation_project/src/auth/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../auth/widgets/custom_scaffold.dart';

class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({
    super.key,
    required this.group,
  });
  final Group group;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton.filled(
            onPressed: () async {
              var temp = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateGroupPage(
                    group: group,
                  ),
                ),
              ) as bool;
              if (temp) {
                Navigator.of(context).pop(true);
              }
            },
            icon: const Icon(Icons.edit),
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white)),
            color: Colors.green,
          ),
          SizedBox(
            width: 10.w,
          ),
          IconButton.filled(
            onPressed: () async {
              try {
                await GroupController().deleteGroup(group.id);
                Navigator.of(context).pop(true);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Error: ${e.toString()}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            icon: const Icon(Icons.delete),
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
            ),
            color: Colors.red,
          ),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => const CreateGroupPage(),
            //   ),
            // );
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 30.h),
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.w),
                  topRight: Radius.circular(20.w),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 165.h,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  height: 80.h,
                                  child: group.imageUrl != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: FadeInImage(
                                            placeholder: const AssetImage(
                                              'assets/images/bg3.jpg',
                                            ),
                                            image: NetworkImage(
                                              group.imageUrl!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: Image.asset(
                                            'assets/images/bg3.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        group.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 25.0.sp,
                                          fontWeight: FontWeight.w900,
                                          color: lightColorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (group.typeId != null)
                            SizedBox(
                              height: 8.h,
                            ),
                          if (group.typeId != null)
                            Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Group Type: ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  TextSpan(
                                    text: group.groupType?.name,
                                    style: TextStyle(
                                      fontSize: 15.0.sp,
                                      fontWeight: FontWeight.w700,
                                      color: lightColorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(
                            height: 8.h,
                          ),
                          SizedBox(
                            height: 45.h,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              label: const Text("Manage Group's Friends"),
                              icon: const Icon(
                                Icons.people,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Divider(
                      thickness: 2.h,
                      color: Colors.black87,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 320.h,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.h, vertical: 20.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.w),
                        ),
                      ),
                      child: true == true
                          ? Center(
                              child: Text(
                                "There is no Data",
                                style: TextStyle(
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.w900,
                                  color: lightColorScheme.primary,
                                ),
                              ),
                            )
                          : const SingleChildScrollView(
                              child: Column(),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
