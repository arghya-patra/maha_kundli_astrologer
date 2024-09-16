import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:http/http.dart' as http;
import 'package:mahakundali_astrologer_app/Components/buttons.dart';
import 'package:mahakundali_astrologer_app/Components/util.dart';
import 'package:mahakundali_astrologer_app/Screens/Auth/otpVerification.dart';
import 'package:mahakundali_astrologer_app/service/apiMAnager.dart';
import 'package:mahakundali_astrologer_app/service/serviceManager.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool _isFormVisible = false;
  bool isLoading = false;

  String? selectedCountryCode = '+91';
  TextEditingController mobile = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _isFormVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepOrange,
                Colors.orange,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedOpacity(
              opacity: _isFormVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login with your phone number',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You will receive an OTP',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: _isFormVisible
                  ? Row(
                      children: [
                        Container(
                          //color: Colors.red,
                          child: CountryListPick(
                            onChanged: (CountryCode? code) {
                              setState(() {
                                selectedCountryCode = code!.dialCode;
                              });
                            },
                            initialSelection: '+91',
                            useSafeArea: true,
                          ),
                        ),
                        //  const SizedBox(width: 2),
                        Expanded(
                          child: TextField(
                            controller: mobile,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 32),
            Center(
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => VideoCallScreen()));
                },
                child: const Text(
                  'Don\'t Have an account? Register Here!',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: isLoading != true
                  ? ElevatedButton(
                      onPressed: () {
                        loginUser(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => OtpVerificationScreen(),
                        //   ),
                        // );
                      },
                      child: const Text('Send Otp'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 15.0),
                      ),
                    )
                  : LoadingButton(),
            ),
            const Spacer(),
            Center(
              child: Text(
                'Some other text as footer',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> loginUser(context) async {
    setState(() {
      isLoading = true;
    });
    String url = APIData.login;
    print(url.toString());
    var res = await http.post(Uri.parse(url), body: {
      'action': 'login',
      'mobile': '7890222444' // mobile.text, //8100007581
    });
    var data = jsonDecode(res.body);

    if (data['status'] == 200) {
      print("______________________________________");
      print(res.body);
      print("______________________________________");
      try {
        print(data['status']);
        print(data['authorizationToken']);
        toastMessage(message: 'Please check your mobile for OTP!');
        // print('${data['userInfo']['id']}');
        // ServiceManager().setUser('${data['userInfo']['id']}');
        ServiceManager().setToken('${data['authorizationToken']}');
        // ServiceManager.userID = '${data['userInfo']['id']}';
        ServiceManager.tokenID = '${data['authorizationToken']}';
        // print(ServiceManager.roleAs);
        // ServiceManager().getUserData();
        // toastMessage(message: 'Logged In');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => OtpVerificationScreen(
                      otp: data['otp'].toString(),
                    )),
            (route) => false);
      } catch (e) {
        toastMessage(message: e.toString());
        setState(() {
          isLoading = false;
        });
        toastMessage(message: 'Something went wrong');
      }
    } else {
      setState(() {
        isLoading = false;
      });
      toastMessage(message: 'Invalid data');
    }
    setState(() {
      isLoading = false;
    });
    return 'Success';
  }
}
