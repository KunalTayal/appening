import 'package:appening/api.dart';
import 'package:flutter/material.dart';
import 'package:appening/profile_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final jobController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GetRequestData getRequestData = GetRequestData();

  @override
  void initState() {
    super.initState();
    nameController.clear();
    jobController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  // Container(
                  //   child: Text("Full Name"),
                  //   alignment: ,
                  // ),
                  buildName(),
                  const SizedBox(height: 30),
                  buildJobName()
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 40,
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                storeProfile();
                nameController.text = "";
                jobController.text = "";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text(
                "Submit",
                style: TextStyle(
                  fontSize: 18,
                ),
              )),
        ),
      ),
    );
  }

  Widget buildName() => TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your name';
          }
          return null;
        },
        controller: nameController,
        decoration: const InputDecoration(
          labelText: 'Full Name',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      );
  Widget buildJobName() => TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your job designation';
          }
          return null;
        },
        controller: jobController,
        decoration: const InputDecoration(
          labelText: 'Job Name',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
      );

  storeProfile() async {
    try {
      String name = nameController.text;
      String job = jobController.text;
      await getRequestData.storeUserData(name, job);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
