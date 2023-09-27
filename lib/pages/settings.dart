import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/provider/user_provider.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LocalUser currentUser = ref.watch(userProvider);
    _nameController.text = currentUser.user.name;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings")
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? pickedImage = await picker.pickImage(
                    source: ImageSource.gallery, requestFullMetadata: false);
                if (pickedImage != null) {
                  ref
                      .read(userProvider.notifier)
                      .updatePicture(File(pickedImage.path));
                }
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(currentUser.user.profilePic),
                radius: 100,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text("Change Profile Picture"),
            ),
            TextFormField(
              controller: _nameController,
              validator: null,
              decoration: const InputDecoration(
                hintText: "Name",
              ),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(userProvider.notifier)
                    .updateName(_nameController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
