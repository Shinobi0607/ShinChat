import 'dart:io'; // Add this import for File class
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const routeName = '/user-information';
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image; // Declare the image variable

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    final pickedImage = await pickImageFromGallery(context);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage; // Assign the picked image to the variable
      });
    }
  }

  void storeUserData() async {
    String name = nameController.text.trim();

    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .saveUserDataToFirebase(context, name, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  // Use a conditional expression to show the image if it's not null
                  image == null
                      ? const CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://www.freepik.com/free-photo/girl-with-backpack-sunset-generative-al_38937974.htm#query=anime&position=9&from_view=keyword&track=sph',
                          ),
                          radius: 64,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                              image!), // Use FileImage if image is not null
                          radius: 64,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: storeUserData,
                    icon: const Icon(Icons.done),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
