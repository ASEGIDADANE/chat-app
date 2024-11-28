import 'dart:io';

import 'package:chat_app/constant.dart';
import 'package:chat_app/services/alert_service.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/database_service.dart';
import 'package:chat_app/services/media_service.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'package:chat_app/services/storage_service.dart';
import 'package:chat_app/widget/custom_text_field.dart';

import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import '../models/user_profile.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _regeisterkey = GlobalKey();
  String? name;
  String? email;
  String? password;
  bool isloading = false;
  final GetIt _getIt = GetIt.instance;
  late MediaService _mediaService;
  late NavigationService _navigationService;
  late AuthService _authService;
  late StorageService _storageService;
  late DatabaseService _databaseService;
  late AlertService _alertService;

  File? selectedImage;
  @override
  void initState() {
    _mediaService = _getIt.get<MediaService>();
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
    _storageService = _getIt.get<StorageService>();
    _databaseService = _getIt.get<DatabaseService>();
    _alertService = _getIt.get<AlertService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          children: [
            _headerText(),
            if (!isloading) _registerForm(),
            if (!isloading) _loginAccountLink(),
            if (isloading)
              Expanded(
                  child: Center(
                child: CircularProgressIndicator(),
              ))
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.of(context).size.width, // Fixed context usage
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'let\'s get going',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'register an account using the form below',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget _registerForm() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.60, // Fixed context usage
      margin: EdgeInsets.symmetric(
        vertical:
            MediaQuery.of(context).size.height * 0.05, // Fixed context usage
      ),
      child: Form(
        key: _regeisterkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            pfpSelectionField(),
            CustomTextField(
              hintText: 'Name',
              height: MediaQuery.sizeOf(context).height * 0.1,
              validationRegEx: namePattern,
              onsaved: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            CustomTextField(
              hintText: 'Email',
              height: MediaQuery.sizeOf(context).height * 0.1,
              validationRegEx: emailPattern,
              onsaved: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            CustomTextField(
              obscureText: true,
              hintText: 'Password',
              height: MediaQuery.sizeOf(context).height * 0.1,
              validationRegEx: passwordPattern,
              onsaved: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            _registerButton(),
          ],
        ),
      ),
    );
  }

  Widget pfpSelectionField() {
    return GestureDetector(
      onTap: () async {
        File? file = await _mediaService.getImageFromGallery();
        if (file != null) {
          print('image is gonne selected');
          setState(() {
            selectedImage = file;
            print('i get image');
          });
        }
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundImage: selectedImage != null
            ? FileImage(selectedImage!)
            : NetworkImage(placeholderProfileImageUrl) as ImageProvider,
      ),
    );
  }

  Widget _registerButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        color: Theme.of(context).colorScheme.primary,
        onPressed: () async {
          setState(() {
            isloading = true;
          });
          try {
            if ((_regeisterkey.currentState?.validate() ?? false) &&
                selectedImage != null) {
              _regeisterkey.currentState?.save();
              bool result = await _authService.signup(email!, password!);
              if (result) {
                print('ase you should sure i am signup');
                String? pfpURL = await _storageService.uploadUser(
                  file: selectedImage!,
                  uid: _authService.user!.uid,
                );
                print('yes i get image');

                if (pfpURL != null) {
                  print('profile is  not empty');
                  await _databaseService.createUserProfile(
                      userprofile: UserProfile(
                    name: name,
                    uid: _authService.user!.uid,
                    pfpURL: pfpURL,
                  ));
                  _alertService.showToast(
                    text: 'user register succesfully',
                    icon: Icons.check,
                  );
                  _navigationService.goBack();
                  _navigationService.pushReplacementNamed('/home');
                } else {
                  print('can not relaod');
                  throw Exception('unable uplaod user profile picture');
                }
              } else {
                print(result);
                throw Exception('unable regsiter user');
              }
            }
          } catch (e) {
            print(e);
            _alertService.showToast(
                text: 'Failed register,please try again', icon: Icons.error);
          }
          setState(() {
            isloading = false;
          });
        },
        child: Text(
          'register',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _loginAccountLink() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Already have an account?'),
          GestureDetector(
            onTap: () {
              _navigationService.pushReplacementNamed('/login');
            },
            child: Text(
              'login',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          )
        ],
      ),
    );
  }
}
