import 'package:expenses_graduation_project/src/Dedels/model/friends_model.dart';
import 'package:expenses_graduation_project/src/Dedels/widget/friends_widget.dart';
import 'package:flutter/material.dart';

class CreateFriends extends StatefulWidget {
  const CreateFriends({super.key, this.friend});

  final Friends? friend;

  @override
  _CreateFriendsState createState() => _CreateFriendsState();
}

class _CreateFriendsState extends State<CreateFriends> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.friend != null) {
      setState(() {
        nameController.text = widget.friend?.name ?? "";
        emailController.text = widget.friend?.email ?? "";
        phoneController.text = widget.friend?.phone ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.friend != null ? 'Update Friend' : 'Add Friend',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                NameField(controller: nameController),
                const SizedBox(height: 16),
                EmailField(controller: emailController),
                const SizedBox(height: 16),
                PhoneField(controller: phoneController),
                const SizedBox(height: 20),
                SubmitButton(
                  formKey: _formKey,
                  nameController: nameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  isUpdate: widget.friend != null,
                  friendId: widget.friend?.id ?? 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
