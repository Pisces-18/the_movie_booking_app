import 'dart:convert';
import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_movie_booking_app/data/models/data_model_impl.dart';
import 'package:the_movie_booking_app/pages/get_otp_page.dart';
import 'package:the_movie_booking_app/pages/location_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import '../data/models/data_model.dart';
import '../resources/dimens.dart';
import '../resources/germs.dart';
import '../resources/strings.dart';
import '../viewers/login_logo_and_text_view.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';
  DataModel dDataModel=DataModelImpl();

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Widget build(BuildContext context) {
    final GoogleSignInAccount? user = _currentUser;
    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.3,
                child: LoginLogoAndTextView(
                    VERIFY_PHONE_NUMBER_TEXT, ANNOUNCE_TO_SEND_SMS_CODE),
              ),
              //const SizedBox(height: MARGIN_XXXLARGE),
              PhoneNumberSectionView(countryCodeList, (phone) {
                setState((){
                  dDataModel.getOTP(phone).then((value) => _navigateToGetOTPPge(context,phone)).catchError((error){
                    debugPrint("Sign in With Phone Errors===>$error");
                  });
                  debugPrint(phone);

                });
              }),
              const SizedBox(height: MARGIN_xXLARGE),
              DividerView(),
              const SizedBox(height: MARGIN_xXLARGE),
              GoogleButtonTextView(() {
                setState(() {
                  _navigateToLocationPage(context);
                });
                // else{
                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>GetOTPPage()));
                // }
              }),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              PrivacyPolicyTextView(),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToLocationPage(BuildContext context) =>
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LocationPage()));

  Future<dynamic> _navigateToGetOTPPge(BuildContext context,String phone) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GetOTPPage(phone),
        ),
      );
}

class PrivacyPolicyTextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        PRIVACY_POLICY_TEXT,
        style: GoogleFonts.dmSans(
          textStyle: Theme.of(context).textTheme.bodySmall,
          fontWeight: FontWeight.w700,
          fontSize: TEXT_SMALL,
          color: PRIVACY_POLICY_TEXT_COLOR,
        ),
      ),
    );
  }
}

class GoogleButtonTextView extends StatefulWidget {
  final Function onPressedGoogle;
  GoogleButtonTextView(this.onPressedGoogle);

  @override
  State<GoogleButtonTextView> createState() => _GoogleButtonTextViewState();
}

class _GoogleButtonTextViewState extends State<GoogleButtonTextView> {
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3LX),
      height: MARGIN_XXXLARGE,
      child: TextButton(
        onPressed: () => widget.onPressedGoogle(),
        style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: MARGIN_MEDIUM,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/google.png"),
              const SizedBox(width: MARGIN_MEDIUM_X),
              const Text(
                GOOLE_BUTTON_TEXT,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: TEXT_REGULAR_2X,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DividerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3LX),
      child: Stack(
        children: [
          const Positioned.fill(
            child: Divider(
              color: DASH_COLOR_2,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: MARGIN_MEDIUM_3,
              ),
              decoration: BoxDecoration(
                  color: PAGE_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.circular(MARGIN_XXXLARGE)),
              child: const Text(
                OR_TEXT,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: TEXT_REGULAR_2X,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PhoneNumberSectionView extends StatefulWidget {
  final List<String> countryCodeList;
  final Function(String) onPressedButton;
  PhoneNumberSectionView(this.countryCodeList, this.onPressedButton);

  @override
  State<PhoneNumberSectionView> createState() => _PhoneNumberSectionViewState();
}

class _PhoneNumberSectionViewState extends State<PhoneNumberSectionView> {
  String dropDownValue = "+95";
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3LX),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            COUNTRY_CODE_TEXT,
            style: GoogleFonts.inter(
              textStyle: Theme.of(context).textTheme.bodySmall,
              fontWeight: FontWeight.w400,
              fontSize: TEXT_SMALL,
              color: SMS_CODE_COLOR,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: [
              DropdownButton<String>(
                elevation: 0,
                dropdownColor: APPBAR_COLOR,
                value: dropDownValue,
                style: GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.bodySmall,
                    color: Colors.white,
                    fontSize: TEXT_REGULAR_2X,
                    fontWeight: FontWeight.w400),
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownValue = newValue!;
                  });
                },
                items: widget.countryCodeList
                    .map((item) =>
                        DropdownMenuItem(value: item, child: Text(item)))
                    .toList(),
              ),
              const SizedBox(width: MARGIN_MEDIUM_2X),
              Container(
                height: MARGIN_xXLARGE,
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  controller: _phoneController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: PHONE_NUMBER_HINT_TEXT,
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: TEXT_REGULAR_2X,
                      color: SMS_CODE_COLOR,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: MARGIN_XxLARGE),
          Container(
            height: MARGIN_XXxxLARGE,
            child: TextButton(
              onPressed: () => widget.onPressedButton(_phoneController.text),
              style: TextButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR_1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                  )),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MARGIN_XXXXXLARGE,
                  vertical: MARGIN_MEDIUM,
                ),
                child: Text(
                  PHONE_NUMBER_TEXT_BUTTON_TEXT,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: TEXT_REGULAR_2X,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
