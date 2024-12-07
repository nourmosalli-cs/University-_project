import 'package:expenses_graduation_project/src/Dedels/controller/group_controller.dart';
import 'package:expenses_graduation_project/src/Dedels/model/group_types_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyTabBarPage extends StatefulWidget {
  const MyTabBarPage({super.key});

  @override
  _MyTabBarPageState createState() => _MyTabBarPageState();
}

class _MyTabBarPageState extends State<MyTabBarPage>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final GroupController groupController = GroupController();

    void showNameDialog({GroupType? groupType}) {
      _nameController.text = groupType?.name ?? '';

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: groupType == null
                ? const Text('Enter Group Name')
                : const Text('Update Group Name'),
            content: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Group Name',
                hintText: groupType == null
                    ? 'Enter the group name'
                    : 'Update the group name',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    setState(() {
                      _isLoading = true;
                    });

                    var id = Supabase.instance.client.auth.currentUser!.id;
                    Map<String, dynamic> data = {
                      'name': _nameController.text,
                      'owner_id': id,
                    };

                    if (groupType == null) {
                      await Supabase.instance.client
                          .from('group_types')
                          .insert(data);
                    } else {
                      await Supabase.instance.client
                          .from('group_types')
                          .update(data)
                          .eq('id', groupType.id);
                    }

                    setState(() {
                      _isLoading = false;
                    });

                    Navigator.of(context).pop();
                  } catch (e) {
                    setState(() {
                      _isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
                    );
                  }
                },
                child: Text(groupType == null ? 'Add' : 'Update'),
              ),
            ],
          );
        },
      );
    }

    void showNameDDialog({GroupType? groupType}) {
      _nameController.text = groupType?.name ?? '';

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: groupType == null
                ? const Text('Enter Bill Category Name')
                : const Text('Update Bill Category Name'),
            content: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Bill Category Name',
                hintText: groupType == null
                    ? 'Enter the bill category name'
                    : 'Update the bill category name',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    setState(() {
                      _isLoading = true;
                    });

                    var id = Supabase.instance.client.auth.currentUser!.id;
                    Map<String, dynamic> data = {
                      'name': _nameController.text,
                      'owner_id': id,
                    };

                    if (groupType == null) {
                      await Supabase.instance.client
                          .from('bill_categories')
                          .insert(data);
                    } else {
                      await Supabase.instance.client
                          .from('bill_categories')
                          .update(data)
                          .eq('id', groupType.id);
                    }

                    setState(() {
                      _isLoading = false;
                    });

                    Navigator.of(context).pop();
                  } catch (e) {
                    setState(() {
                      _isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
                    );
                  }
                },
                child: Text(groupType == null ? 'Add' : 'Update'),
              ),
            ],
          );
        },
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Categories'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.blue,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'الصفحة 1'),
              Tab(text: 'الصفحة 2'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // Page 1
            FutureBuilder<Object>(
              future: groupController.fetchGroupTypes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final list = snapshot.data as List<GroupType>;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(list[index].name),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        groupController.deleteGroupTypes(list[index].id);
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            title: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/bg3.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    list[index].name,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    showNameDialog(groupType: list[index]);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            // Page 2
            FutureBuilder<Object>(
              future: groupController.fetchBillTypes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final list = snapshot.data as List<GroupType>;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(list[index].name),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        groupController.deleteBillTypes(list[index].id);
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            title: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/bg3.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    list[index].name,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    showNameDDialog(groupType: list[index]);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () {
                if (_tabController.index == 0) {
                  showNameDialog(); // Show dialog for page 1
                } else if (_tabController.index == 1) {
                  showNameDDialog(); // Show dialog for page 2
                }
              },
              tooltip: 'Add',
              child: const Icon(Icons.add),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
