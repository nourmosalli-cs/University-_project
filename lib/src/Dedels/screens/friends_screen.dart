import 'package:expenses_graduation_project/src/Dedels/controller/group_controller.dart';
import 'package:expenses_graduation_project/src/Dedels/model/friends_model.dart';
import 'package:expenses_graduation_project/src/Dedels/screens/CreateGroupPage.dart';
import 'package:expenses_graduation_project/src/Dedels/screens/create_friends.dart';
import 'package:expenses_graduation_project/src/Dedels/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final GroupController _groupController = GroupController();
  bool _isLoading = false;
  List<Friends> friendsList = [];
  List<Friends> filteredFriends = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterFriends);
    fetchFriends();
  }

  Future<void> fetchFriends() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final friends = await _groupController.fetchfriends();
      setState(() {
        friendsList = friends;
        filteredFriends = friends;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching friends: $e')),
      );
    }
  }

  void _filterFriends() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredFriends = friendsList.where((friend) {
        return friend.name?.toLowerCase().contains(query) ?? false;
      }).toList();
    });
  }

  Future<void> deleteFriend(int id) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await _groupController.deletefriends(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Friend with ID $id deleted successfully!')),
      );
      fetchFriends();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting friend: $e')),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterFriends);
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
          'Friends',
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
                  SearchWidget(
                    controller: _searchController,
                    onSearch: (query) => _filterFriends(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        filteredFriends.isEmpty
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
                                    itemCount: filteredFriends.length,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        key: Key(
                                            filteredFriends[index].name ?? ""),
                                        direction: DismissDirection.endToStart,
                                        onDismissed: (direction) {
                                          deleteFriend(
                                              filteredFriends[index].id);
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
                                            var isUpdated =
                                                await Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateFriends(
                                                friend: filteredFriends[index],
                                              ),
                                            )) as bool;
                                            if (isUpdated) {
                                              fetchFriends();
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.blue.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          filteredFriends[index]
                                                                  .name ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  // Display phone if available
                                                  if (filteredFriends[index]
                                                              .phone !=
                                                          null &&
                                                      filteredFriends[index]
                                                          .phone!
                                                          .isNotEmpty)
                                                    Text(
                                                      'Phone: ${filteredFriends[index].phone}',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                  // Display email if available and phone is not present
                                                  if (filteredFriends[index]
                                                              .email !=
                                                          null &&
                                                      filteredFriends[index]
                                                          .email!
                                                          .isNotEmpty)
                                                    Text(
                                                      'Email: ${filteredFriends[index].email}',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.grey[700],
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
                                builder: (e) => const CreateFriends(),
                              ),
                            ) as bool;
                            if (temp) {
                              fetchFriends();
                            }
                          },
                          icon: const Icon(Icons.group_add),
                          label: Text(
                            'Add a new friend',
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
