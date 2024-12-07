import 'package:expenses_graduation_project/src/Dedels/controller/group_controller.dart';
import 'package:expenses_graduation_project/src/Dedels/model/group_model.dart';
import 'package:expenses_graduation_project/src/Dedels/screens/CreateGroupPage.dart';
import 'package:expenses_graduation_project/src/Dedels/screens/group_details_screen.dart';
import 'package:expenses_graduation_project/src/Dedels/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../core/file_controller.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final GroupController _groupController = GroupController();
  bool _isLoading = false;
  List<Group> groupNames = [];
  List<Group> filteredGroups = [];
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = true; // Variable to track loading state

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterGroups);
    _fetchGroups();
  }

  // Fetch groups from the database
  Future<void> _fetchGroups() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final groups = await _groupController.fetchGroups();
      setState(() {
        groupNames = groups;
        filteredGroups = groups; // Initially show all groups
        _isLoading = false; // Data has been fetched, update loading state
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // If there is an error, stop loading
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching groups: $e')),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  // Filter groups based on the search query
  void _filterGroups() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredGroups = groupNames.where((group) {
        return group.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  // Delete a group
  Future<void> _deleteGroup(Group group) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await _groupController.deleteGroup(group.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Group "${group.name}" deleted successfully!')),
      );
      _fetchGroups(); // Refresh the group list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting group: $e')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterGroups);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => ZoomDrawer.of(context)!.toggle(),
          child: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Groups',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.dm,
          ),
        ),
        centerTitle: true,
        actions: [
          const Icon(
            Icons.qr_code_scanner,
            color: Colors.black,
          ),
          SizedBox(
            width: 10.w,
          ),
          const Icon(
            Icons.shopping_bag_outlined,
            color: Colors.black,
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  // استدعاء ويدجت البحث هنا
                  SearchWidget(
                    controller: _searchController,
                    onSearch: (query) => _filterGroups(), // ربط البحث بالوظيفة
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Display filtered groups or empty state
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        filteredGroups.isEmpty
                            ? Center(
                                child: Image.asset(
                                  'assets/images/bg3.jpg',
                                  height: 200.h,
                                  width: 200.w,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: filteredGroups.length,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        key: Key(filteredGroups[index].name),
                                        direction: DismissDirection.endToStart,
                                        onDismissed: (direction) {
                                          // Call the delete group function
                                          _deleteGroup(filteredGroups[index]);
                                          if (filteredGroups[index].imageUrl !=
                                              null) {
                                            FileController().deleteFile(
                                                filteredGroups[index].imageUrl!,
                                                "group");
                                          }
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          alignment: Alignment.centerRight,
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: GestureDetector(
                                          onTap: () async {
                                            var temp = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (e) =>
                                                    GroupDetailsScreen(
                                                  group: filteredGroups[index],
                                                ),
                                              ),
                                            ) as bool;
                                            if (temp) {
                                              _fetchGroups();
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            // إضافة اللون أو أي تأثير آخر لكل عنصر
                                            decoration: BoxDecoration(
                                              color: Colors.blue
                                                  .shade50, // لون خلفية العنصر
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10), // زاوية مستديرة
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0, 2),
                                                  blurRadius: 6,
                                                ),
                                              ],
                                            ),
                                            child: ListTile(
                                              contentPadding:
                                                  const EdgeInsets.all(8.0),
                                              title: Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    width: 40.0,
                                                    height: 40.0,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/bg3.jpg'), // يمكن تغيير الصورة هنا
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  // Group Name
                                                  Expanded(
                                                    child: Text(
                                                      filteredGroups[index]
                                                          .name,
                                                      style: const TextStyle(
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                        SizedBox(height: 30.h),
                        ElevatedButton.icon(
                          onPressed: () async {
                            var temp = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (e) => const CreateGroupPage(),
                              ),
                            ) as bool;
                            if (temp) {
                              _fetchGroups();
                            }
                          },
                          icon: const Icon(Icons.group_add),
                          label: Text(
                            'Create a new group',
                            style: TextStyle(fontSize: 10.dm),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
    );
  }
}
