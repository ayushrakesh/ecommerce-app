import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/helper/keyboard.dart';
import 'package:ecommerce_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:ecommerce_app/screens/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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

  @override
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

        firstNameCtl.clear();
        lastnameCtl.clear();
        phoneCtl.clear();

        setState(() {
          isloading = true;
        });

        final imageRef = FirebaseStorage.instance
            .ref()
            .child('user-images')
            .child('$currentUserid.jpg');

        final testimg = imageRef.putFile(imgFile!);

        final userimagedownloadurl = await imageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserid)
            .update({
          'first-name': firstName!.trim(),
          'last-name': lastName!.trim(),
          'phone': phoneNumber!.trim(),
          'image': userimagedownloadurl,
        });

        // Directory appDocDir = await getApplicationDocumentsDirectory();
        // String filePath = '${appDocDir.absolute}/$imagesRef';
        // File file = File(filePath);

        setState(() {
          isloading = false;
        });

        if (isloading == false) {
          Navigator.pushNamed(context, ProfileScreen.routeName);
        }
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          ProfilePic(imgFile),
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
