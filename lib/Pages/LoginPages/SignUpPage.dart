import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:no_signal/providers/UserData.dart';
import 'package:no_signal/themes.dart';

import '../HomePage.dart';

class CreateAccountPage extends StatefulWidget {
  static const routeName = '/create-account';
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _bio = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final ImagePicker _picker = ImagePicker();

  XFile? _image;

  Future<void> pickImage(ImagePicker picker) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    print(_image!.path);
  }

  bool _isloading = false;
  @override
  void dispose() {
    _name.dispose();
    _bio.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Consumer(builder: (context, watch, _) {
            final _createUser = watch(userDataClassProvider);
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 50,
                        color: Colors.white,
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Create Your Profile',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        enableFeedback: true,
                        onTap: () => pickImage(_picker),
                        child: Stack(
                          children: [
                            CircleAvatar(
                                radius: 56,
                                backgroundColor: NoSignalTheme.whiteShade1,
                                child: CircleAvatar(
                                  radius: 52,
                                  backgroundImage: _image == null
                                      ? AssetImage('assets/images/avatar.png')
                                          as ImageProvider<Object>
                                      : FileImage(File(_image!.path)),
                                )),
                            Positioned(
                              bottom: 2,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: NoSignalTheme.whiteShade1,
                                radius: 15,
                                child: Icon(
                                  Icons.add,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: TextFormField(
                      autocorrect: true,
                      enableSuggestions: true,
                      controller: _name,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Name',
                        alignLabelWithHint: true,
                        // border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Pls enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: NoSignalTheme.whiteShade1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      autocorrect: true,
                      controller: _bio,
                      enableSuggestions: true,
                      maxLines: 7,
                      maxLength: 100,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {},
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Bio',
                        alignLabelWithHint: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'It must not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  Spacer(),
                  _isloading
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          padding: const EdgeInsets.only(top: 48.0),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              _image != null
                                  ? await _createUser
                                      .addProfilePicture(
                                          _image!.path, _image!.name)
                                      .then((url) => _createUser.addUser(
                                          _name.text, _bio.text, url ?? ''))
                                  : _createUser.addUser(_name.text, _bio.text,
                                      'assets/images/profile.png');

                              await Navigator.of(context)
                                  .pushReplacementNamed(HomePage.routename);
                            },
                            child: Text(
                              'Create User',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            // textColor: TwitterTheme.blueTColor,
                            textTheme: ButtonTextTheme.primary,
                            minWidth: 100,
                            padding: const EdgeInsets.all(18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side:
                                  BorderSide(color: NoSignalTheme.whiteShade1),
                            ),
                          ),
                        ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
