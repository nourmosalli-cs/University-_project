import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;

  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value != null &&
            value.isNotEmpty &&
            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}

class PhoneField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Phone',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value != null &&
            value.isNotEmpty &&
            !RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final bool? isUpdate;
  final int? friendId;

  const SubmitButton({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    this.isUpdate = false,
    this.friendId = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.blue[700], // Full-width button
        padding: const EdgeInsets.symmetric(vertical: 14), // Button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () async {
        if (!formKey.currentState!.validate()) {
          return; // If validation fails, do nothing
        }

        if (emailController.text.isEmpty && phoneController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please fill at least one of email or phone'),
            ),
          );
          return;
        }

        // Add data to Supabase
        var id = Supabase.instance.client.auth.currentUser!.id;
        Map<String, dynamic> data = {
          'name': nameController.text,
          'email': emailController.text.isEmpty ? null : emailController.text,
          'phone_number':
              phoneController.text.isEmpty ? null : phoneController.text,
          'owner_id': id,
        };
        if (isUpdate!) {
          await Supabase.instance.client
              .from('friends')
              .update(data)
              .eq("id", friendId!);
        } else {
          await Supabase.instance.client.from('friends').insert(data);
        }
        Navigator.of(context).pop(true);
      },
      child: Text(isUpdate! ? 'Update Friend' : 'Add Friend'),
    );
  }
}
