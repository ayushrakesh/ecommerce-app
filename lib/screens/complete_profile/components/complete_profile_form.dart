import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/helper/keyboard.dart';
import 'package:ecommerce_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:ecommerce_app/screens/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../otp/otp_screen.dart';
import '../../profile/components/profile_pic.dart';

class CompleteProfileForm extends StatefulWidget {
  CompleteProfileForm();

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();

  String? firstName;
  String? lastName;
  String? phoneNumber;

  final firstNameCtl = TextEditingController();
  final lastnameCtl = TextEditingController();
  final phoneCtl = TextEditingController();

  final height = Get.height;
  final width = Get.width;

  bool isloading = false;

  final currentUserid = FirebaseAuth.instance.currentUser!.uid;

  var userdata;

  File? imgFile;

  // @override
  // void initState() {
  //   getuserdata();
  //   super.initState();
  // }

  // void getuserdata() async {
  //   final data = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();

  //   final userData = data.data();

  //   setState(() {
  //     userdata = userData;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    void saveDetails() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        KeyboardUtil.hideKeyboard(context);
        FocusScope.of(context).unfocus();

        print(firstName);
        print(lastName);
        print(phoneNumber);

        firstNameCtl.clear();
        lastnameCtl.clear();
        phoneCtl.clear();

        setState(() {
          isloading = true;
        });

        if (imgFile != null) {
          final storage = FirebaseStorage.instance.ref();
          final userImgesFolder = storage.child('user-images');
          final userImageRF = userImgesFolder.child('$currentUserid.jpg');

          await userImageRF.putFile(imgFile!);

          final userimagedownloadurl = await userImageRF.getDownloadURL();

          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUserid)
              .update(
            {
              'image': userimagedownloadurl,
            },
          );
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserid)
            .update({
          'first-name': firstName!.trim(),
          'last-name': lastName!.trim(),
          'phone': phoneNumber!.trim(),
        });

        setState(() {
          isloading = false;
        });

        if (isloading == false) {
          Navigator.of(context).pop();
        }
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  backgroundImage: imgFile != null
                      ? FileImage(imgFile!) as ImageProvider
                      : const AssetImage('assets/images/user.png')
                          as ImageProvider,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     image: DecorationImage(
                //       image: imgFile != null
                //           ? FileImage(imgFile!)
                //           : const AssetImage('assets/images/user.png')
                //               as ImageProvider,
                //     ),
                //   ),
                // ),
                Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white),
                        ),
                        primary: Colors.white,
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: () async {
                        var img = await ImagePicker().pickImage(
                          source: ImageSource.camera,
                          imageQuality: 50,
                        );

                        setState(() {
                          imgFile = File(img!.path);
                        });
                      },
                      child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                    ),
                  ),
                )
              ],
            ),
          ),
          Gap(height * 0.03),
          buildFirstNameFormField(),
          Gap(height * 0.03),
          buildLastNameFormField(),
          Gap(height * 0.03),
          buildPhoneNumberFormField(),
          Gap(height * 0.05),
          !isloading
              ? DefaultButton(
                  text: "Save details",
                  press: saveDetails,
                )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: phoneCtl,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        setState(() {
          phoneNumber = value;
        });
      },
      validator: (value) {
        if (value!.length < 10) {
          return "Please provide a valid phone number.";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: lastnameCtl,
      onChanged: (value) {
        setState(() {
          lastName = value;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Last name must not be empty.';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: firstNameCtl,
      onChanged: (value) {
        setState(() {
          firstName = value;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Provide a valid name.";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
