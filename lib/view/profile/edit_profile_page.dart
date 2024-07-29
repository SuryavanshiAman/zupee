// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:zupee/main.dart';
// import 'package:zupee/res/app_colors.dart';
// import 'package:zupee/res/custom_text_field.dart';
//
// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});
//
//   @override
//   _EditProfileScreenState createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   String _phoneNumber = "+9163xxxx0498";
//   String _selectedPrivacyOption = "Everyone";
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController.text = _phoneNumber;
//   }
//
//   Future<void> _openCamera() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       setState(() {
//         // Handle the image picked from the camera
//       });
//     }
//   }
//
//   Future<void> _selectFromGallery() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         // Handle the image picked from the gallery
//       });
//     }
//   }
//
//   void _selectAvatar() {
//     setState(() {
//       // Handle avatar selection
//     });
//   }
//
//   void _saveChanges() {
//     // Handle save changes
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appBarColor,
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(18),
//               decoration: const BoxDecoration(
//                   color: white,
//                   borderRadius: BorderRadius.all(Radius.circular(20))),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Set Profile Picture",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(
//                     height: height * 0.03,
//                   ),
//                   const Center(
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Colors.yellow,
//                       child: Icon(Icons.person, size: 40),
//                     ),
//                   ),
//                   SizedBox(
//                     height: height * 0.03,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Column(
//                         children: [
//                           CircleAvatar(
//                             radius: 26,
//                             child: IconButton(
//                               icon: const Icon(
//                                 Icons.camera_alt_outlined,
//                                 color: tertiary,
//                               ),
//                               onPressed: _openCamera,
//                             ),
//                           ),
//                           const Text(
//                             'Open \nCamera',
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           CircleAvatar(
//                             radius: 26,
//                             child: IconButton(
//                               icon: const Icon(Icons.photo_camera_back_outlined,
//                                   color: tertiary),
//                               onPressed: _selectFromGallery,
//                             ),
//                           ),
//                           const Text(
//                             'Select from \nGallery',
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           CircleAvatar(
//                             radius: 26,
//                             child: IconButton(
//                               icon: const Icon(Icons.person_outline,
//                                   color: tertiary),
//                               onPressed: _selectAvatar,
//                             ),
//                           ),
//                           const Text(
//                             'Select \nAvatar',
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             Container(
//               padding: const EdgeInsets.all(18),
//               decoration: const BoxDecoration(
//                   color: white,
//                   borderRadius: BorderRadius.all(Radius.circular(20))),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Set Display Name",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//                   ),
//                   const Text(
//                     "Numbers, special characters are not allowed",
//                     style: TextStyle(fontSize: 14, color: labelColor),
//                   ),
//                   SizedBox(
//                     height: height * 0.02,
//                   ),
//                   CustomTextField(
//                     height: height * 0.08,
//                     filled: true,
//                     fillColor: lightBlue,
//                     fieldRadius: const BorderRadius.all(Radius.circular(25)),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             Container(
//                 padding: const EdgeInsets.all(18),
//                 decoration: const BoxDecoration(
//                     color: white,
//                     borderRadius: BorderRadius.all(Radius.circular(20))),
//                 child:Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Privacy Management",
//                       style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//                     ),
//                     const Text(
//                       "Control who can see your game history",
//                       style: TextStyle(fontSize: 14, color: labelColor),
//                     ),
//                     // SizedBox(
//                     //   height: height * 0.02,
//                     // ),
//                     // CustomTextField(
//                     //   height: height * 0.08,
//                     //   filled: true,
//                     //   fillColor: lightBlue,
//                     //   fieldRadius: BorderRadius.all(Radius.circular(25)),
//                     // ),
//                     Row(
//                       children: [
//                         const Text(
//                           "My Game History",
//                           style: TextStyle(fontSize: 14, color: labelColor),
//                         ),
//                         InkWell(
//                           onTap: (){
//                             _showBottomSheet( context);
//                           },
//                           child: Container(
//                             height: height*0.03,
//                             width: width*0.3,
//                             decoration: const BoxDecoration(
//                               color: lightBlue,
//                               borderRadius: BorderRadius.all(Radius.circular(25))
//                             ),
//                             child: Text(_selectedOption),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 )
//             ),
//
//             const Spacer(),
//             ElevatedButton(
//               onPressed: _saveChanges,
//               child: const Text('Save Changes'),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 45),
//                 backgroundColor: Colors.grey, // Button color
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   void _showBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return PrivacyOptionsBottomSheet();
//       },
//     );
//   }
// }
//
// class PrivacyOptionsBottomSheet extends StatefulWidget {
//   @override
//   _PrivacyOptionsBottomSheetState createState() => _PrivacyOptionsBottomSheetState();
// }
//
// class _PrivacyOptionsBottomSheetState extends State<PrivacyOptionsBottomSheet> {
//   String _selectedOption = 'Only me';
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(left: 350.0),
//             child: Icon( Icons.close),
//           ),
//           const Text(
//             'Privacy Options: My Game \nHistory',
//             style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),
//           ListTile(
//             leading: const Icon( Icons.visibility),
//             title: const Text('Everyone'),
//             subtitle: const Text('Anyone on the Zupee platform will be able to see',style: TextStyle(fontSize: 10,color: labelColor)),
//             trailing: Radio<String>(
//               value: 'Everyone',
//               groupValue: _selectedOption,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedOption = value!;
//                 });
//               },
//             ),
//           ),
//           ListTile(
//             leading: const Icon( Icons.lock),
//             title: const Text('Only me'),
//             subtitle: const Text('Nobody can see',style: TextStyle(fontSize: 10,color: labelColor)),
//             trailing: Radio<String>(
//               value: 'Only me',
//               groupValue: _selectedOption,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedOption = value!;
//                 });
//               },
//             ),
//           ),
//           ListTile(
//             leading: const Icon( Icons.people),
//             title: const Text('My Connections'),
//             subtitle: const Text('Only your connections (followers and following) will be able to see',style: TextStyle(fontSize: 10,color: labelColor)),
//             trailing: Radio<String>(
//               value: 'My Connections',
//               groupValue: _selectedOption,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedOption = value!;
//                 });
//               },
//             ),
//           ),
//           const SizedBox(height: 20),
//           Center(
//             child: Container(
//               alignment: Alignment.center,
//               height: height*0.06,
//               width: width*0.8,
//               decoration: const BoxDecoration(
//                   color: secondary,
//                   borderRadius: BorderRadius.all(Radius.circular(20))),
//               child: Text("Done",style: TextStyle(fontWeight: FontWeight.w600,color: tertiary),),
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _phoneNumber = "+9163xxxx0498";
  String _selectedPrivacyOption = "Everyone";
  IconData _selectedPrivacyIcon = Icons.visibility;

  @override
  void initState() {
    super.initState();
    _nameController.text = _phoneNumber;
  }

  Future<void> _openCamera() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        // Handle the image picked from the camera
      });
    }
  }

  Future<void> _selectFromGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        // Handle the image picked from the gallery
      });
    }
  }

  void _selectAvatar() {
    setState(() {
      // Handle avatar selection
    });
  }

  void _saveChanges() {
    // Handle save changes
  }

  void _showBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return PrivacyOptionsBottomSheet(
          selectedOption: _selectedPrivacyOption,
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedPrivacyOption = result['option'];
        _selectedPrivacyIcon = result['icon'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Set Profile Picture",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.yellow,
                      child: Icon(Icons.person, size: 40),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                color: tertiary,
                              ),
                              onPressed: _openCamera,
                            ),
                          ),
                          const Text(
                            'Open \nCamera',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            child: IconButton(
                              icon: const Icon(Icons.photo_camera_back_outlined,
                                  color: tertiary),
                              onPressed: _selectFromGallery,
                            ),
                          ),
                          const Text(
                            'Select from \nGallery',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            child: IconButton(
                              icon: const Icon(Icons.person_outline,
                                  color: tertiary),
                              onPressed: _selectAvatar,
                            ),
                          ),
                          const Text(
                            'Select \nAvatar',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Set Display Name",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    "Numbers, special characters are not allowed",
                    style: TextStyle(fontSize: 14, color: labelColor),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextField(
                    contentPadding: EdgeInsets.all(15),
                    controller:_nameController ,
                    height: height * 0.08,
                    filled: true,
                    fillColor: lightBlue,
                    fieldRadius: const BorderRadius.all(Radius.circular(25)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Privacy Management",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      "Control who can see your game history",
                      style: TextStyle(fontSize: 14, color: labelColor),
                    ),
                    SizedBox(height: height*0.03,),
                    Row(
                      children: [
                        const Text(
                          "My Game History",
                          style: TextStyle(fontSize: 14, color: labelColor),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            _showBottomSheet(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            height: height * 0.035,
                            width: width * 0.4,
                            decoration: const BoxDecoration(
                              color: lightBlue,
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(_selectedPrivacyIcon, size: 16, color: black),
                                const SizedBox(width: 4),
                                Text(_selectedPrivacyOption,style: TextStyle(fontSize: 13),),
                                Spacer(),
                                Icon(Icons.keyboard_arrow_down, size: 16, color: tertiary),
                              ],
                            ),
                          ),
                        ),

                      ],
                    )
                  ],
                )),
            const Spacer(),
            Center(
              child: Container(
                alignment: Alignment.center,
                height: height * 0.06,
                width: width * 0.8,
                decoration: const BoxDecoration(
                    color: lightGray,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(fontWeight: FontWeight.w600, color: labelColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyOptionsBottomSheet extends StatefulWidget {
  final String selectedOption;

  const PrivacyOptionsBottomSheet({
    Key? key,
    required this.selectedOption,
  }) : super(key: key);

  @override
  _PrivacyOptionsBottomSheetState createState() =>
      _PrivacyOptionsBottomSheetState();
}

class _PrivacyOptionsBottomSheetState
    extends State<PrivacyOptionsBottomSheet> {
  late String _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 350.0),
            child: Icon(Icons.close),
          ),
          const Text(
            'Privacy Options: My Game \nHistory',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.visibility),
            title: const Text('Everyone'),
            subtitle: const Text(
              'Anyone on the Zupee platform will be able to see',
              style: TextStyle(fontSize: 10, color: labelColor),
            ),
            trailing: Radio<String>(
              value: 'Everyone',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
                Navigator.pop(context, {
                  'option': value,
                  'icon': Icons.visibility,
                });
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Only me'),
            subtitle: const Text(
              'Nobody can see',
              style: TextStyle(fontSize: 10, color: labelColor),
            ),
            trailing: Radio<String>(
              value: 'Only me',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
                Navigator.pop(context, {
                  'option': value,
                  'icon': Icons.lock,
                });
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('My Connections'),
            subtitle: const Text(
              'Only your connections (followers and following) will be able to see',
              style: TextStyle(fontSize: 10, color: labelColor),
            ),
            trailing: Radio<String>(
              value: 'My Connections',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
                Navigator.pop(context, {
                  'option': value,
                  'icon': Icons.people,
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              alignment: Alignment.center,
              height: height * 0.06,
              width: width * 0.8,
              decoration: const BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Text(
                "Done",
                style: TextStyle(fontWeight: FontWeight.w600, color: tertiary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
