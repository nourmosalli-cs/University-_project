import 'dart:io';
import 'dart:math';

import 'package:expenses_graduation_project/src/Dedels/model/group_model.dart';
import 'package:expenses_graduation_project/src/Dedels/model/group_types_model.dart';
import 'package:expenses_graduation_project/src/Dedels/screens/group.dart';
import 'package:expenses_graduation_project/src/Dedels/widget/ConfirmationDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/file_controller.dart';
import '../controller/group_controller.dart';
// Import the new page

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key, this.group});
  final Group? group;

  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final GroupController _groupController = GroupController();
  final TextEditingController mygroupcontroller = TextEditingController();
  List<GroupType> _groupTypes = [];

  XFile? _image;
  GroupType? _groupType;
  bool _isLoading = false;
  bool _isLoadingCategory = false;
  String? _imageUrl;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.group != null) {
      mygroupcontroller.text = widget.group!.name;
      _imageUrl = widget.group?.imageUrl;
    }
    _fetchGroupTypes();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.group != null && _imageUrl != null) {
      widget.group?.imageUrl = _imageUrl;
    }
  }

  Future<void> _fetchGroupTypes() async {
    try {
      setState(() {
        _isLoadingCategory = true;
      });
      final groupTypes = await _groupController.fetchGroupTypes();
      if (widget.group != null && widget.group!.typeId != null) {
        try {
          var temp = groupTypes.firstWhere(
            (element) => element.id == widget.group!.typeId,
          );
          _groupType = temp;
        } catch (e) {
          print(e.toString());
        }
      }
      setState(() {
        _groupTypes = groupTypes;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching groups: $e')),
      );
    }
    setState(() {
      _isLoadingCategory = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create a group',
          style: TextStyle(fontSize: 17.dm),
        ),
        actions: _isLoading
            ? [
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: CircularProgressIndicator(),
                )
              ]
            : [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    if (mygroupcontroller.text.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmationDialog(
                            onConfirm: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            onCancel: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.done),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        setState(() {
                          _isLoading = true;
                        });
                        var id = Supabase.instance.client.auth.currentUser!.id;
                        Map<String, dynamic> data = {
                          'name': mygroupcontroller.text,
                          'owner_id': id,
                        };
                        if (_groupType != null) {
                          data.addAll({
                            "type_id": _groupType?.id,
                          });
                        }
                        if (_image != null) {
                          final imageExtension =
                              _image!.path.split(".").last.toLowerCase();
                          final image = await _image!.readAsBytes();
                          final imagePath =
                              "$id/groups/${DateTime.now().millisecondsSinceEpoch.toString() + Random().nextInt(10000).toString()}.$imageExtension";
                          await Supabase.instance.client.storage
                              .from('group')
                              .uploadBinary(imagePath, image,
                                  fileOptions: FileOptions(
                                    contentType: "image/$imageExtension",
                                    upsert: true,
                                  ));
                          var imageUrl = Supabase.instance.client.storage
                              .from('group')
                              .getPublicUrl(imagePath);
                          imageUrl =
                              Uri.parse(imageUrl).replace(queryParameters: {
                            "t": DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                          }).toString();
                          data.addAll({
                            "image_url": imageUrl,
                          });
                        }
                        if (widget.group != null) {
                          if (_imageUrl != null) {
                            FileController().deleteFile(_imageUrl!, "group");
                            data.addAll({
                              "image_url": null,
                            });
                            _imageUrl = null;
                          }
                          await Supabase.instance.client
                              .from('groups')
                              .update(data)
                              .eq("id", widget.group!.id);
                        } else {
                          await Supabase.instance.client
                              .from('groups')
                              .insert(data);
                        }
                        Navigator.of(context).pop(true);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e.toString()}')),
                        );
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                ),
              ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                      image: _image != null || widget.group?.imageUrl != null
                          ? widget.group?.imageUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(widget.group!.imageUrl!),
                                  fit: BoxFit.fill,
                                )
                              : DecorationImage(
                                  image: FileImage(File(_image!.path)),
                                  fit: BoxFit.fill,
                                )
                          : null),
                  child: _image != null || widget.group?.imageUrl != null
                      ? Container()
                      : const Center(
                          child: Text("Please pick an image"),
                        ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: mygroupcontroller,
                      decoration: InputDecoration(
                        labelText: 'Group Name',
                        hintText: 'Enter group name',
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a group name';
                        }

                        if (value.length < 3) {
                          return 'Group name must be at least 5 characters long';
                        }

                        if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
                          return 'Group name can only contain letters, numbers, and spaces';
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _image = null;
                        if (widget.group != null) {
                          _imageUrl = widget.group?.imageUrl;
                          widget.group?.imageUrl = null;
                        }
                      });
                    },
                    icon: const Icon(Icons.remove),
                    label: Container(),
                  )
                ],
              ),
              SizedBox(height: 16.0.h),
              _isLoadingCategory
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : DropdownButtonFormField<GroupType>(
                      value: _groupType,
                      items: _groupTypes.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _groupType = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Type',
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
