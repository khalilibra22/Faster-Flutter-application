import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'configuration.dart';
import '../classes/mSystem.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../classes/User.dart';

class UserPage extends StatefulWidget {
  UserPage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<UserPage> {
  bool IsHashedPassword = true;
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  bool _isDataLoading = true;
  bool isInfoLoad = false;
  @override
  void initState() {
    _userData().then((value) => this.changeScreen());
    super.initState();

    //bool IsRegistred =  mSystemLocator().getUserInfo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5094E5),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[],
                    ))
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('FASTER',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                SizedBox(width: 10.0),
                Text('User',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 25.0))
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
              height: MediaQuery.of(context).size.height - 180.0,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: /*_userInfoForm()*/ _isDataLoading
                  ? _loadingForm()
                  : _userInfoForm())
        ],
      ),
    );
  }

  Widget InputWidget(String InputTypeTxt, String HintTxt, final InputType,
      final IconType, final SuffixIconType, bool isPassword, final controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          InputTypeTxt,
          style: TextStyle(
            color: Colors.grey[600],
            //fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: shadowList,
              borderRadius: BorderRadius.circular(10.0)),
          height: 50.0,
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: InputType,
            style: TextStyle(
              fontSize: 14.5,
              color: Colors.grey[500],
              fontFamily: 'Montserrat',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: IconType,
              suffixIcon: SuffixIconType,
              hintText: HintTxt,
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _saveBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (!_validateInputs()) return;

          _bottomPopupSheet(context);
          bool isUpdated = await mSystemLocator().setUserInfo(
              fullNameController.text,
              emailController.text,
              phoneController.text,
              addressController.text);
          if (!isUpdated) return;
          Navigator.pop(context);

          print('updated!!');
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFF5094E5),
        child: Text(
          'Enregistrer',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 17.0,
            //fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  Widget _loadingForm() {
    return Shimmer.fromColors(
        child: ListView(
          primary: false,
          padding: EdgeInsets.only(left: 55.0, right: 40.0),
          children: <Widget>[
            SizedBox(
              height: 35.0,
            ),
            Container(
              margin: EdgeInsets.only(right: 120.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  //boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(5.0)),
              height: 15.0,
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  //boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(10.0)),
              height: 50.0,
            ),
            SizedBox(height: 13.0),
            Container(
              margin: EdgeInsets.only(right: 120.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  //boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(5.0)),
              height: 15.0,
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  //boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(10.0)),
              height: 50.0,
            ),
            SizedBox(
              height: 13.0,
            ),
            Container(
              margin: EdgeInsets.only(right: 120.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  //boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(5.0)),
              height: 15.0,
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  //boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(10.0)),
              height: 50.0,
            ),
            SizedBox(
              height: 13.0,
            ),
            Container(
              margin: EdgeInsets.only(right: 120.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  //boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(5.0)),
              height: 15.0,
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  //boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(10.0)),
              height: 50.0,
            ),
            SizedBox(
              height: 13.0,
            ),
            Container(
              margin: EdgeInsets.only(right: 120.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  //boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(5.0)),
              height: 15.0,
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  //boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(10.0)),
              height: 50.0,
            ),
            SizedBox(height: 16.0),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  //boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(25.0)),
              height: 50.0,
              width: double.infinity,
            ),
          ],
        ),
        baseColor: Colors.grey[400],
        highlightColor: Colors.grey[300]);
  }

  Future _userData() async {
    bool isData = await mSystemLocator().getUserInfo();
    if (!isData) {
      return;
    } else {
      fullNameController.text = User.fullName;
      phoneController.text = User.phone;
      emailController.text = User.email;
      addressController.text = User.adress;
      passwordController.text = 'JeSuisMotDePass';
    }
  }

  Widget _userInfoForm() {
    return ListView(
      primary: false,
      padding: EdgeInsets.only(left: 55.0, right: 40.0),
      children: <Widget>[
        SizedBox(
          height: 35.0,
        ),
        InputWidget(
            'Nom Complet',
            'Entrer votre nom',
            TextInputType.text,
            Icon(
              Icons.supervised_user_circle,
              color: Colors.grey[500],
            ),
            null,
            false,
            fullNameController),
        SizedBox(
          height: 10.0,
        ),
        InputWidget(
            'N° Téléphone',
            'Entrer votre N° de téléphone',
            TextInputType.phone,
            Icon(
              Icons.phone_iphone,
              color: Colors.grey[500],
            ),
            null,
            false,
            phoneController),
        SizedBox(
          height: 10.0,
        ),
        InputWidget(
            'Email',
            'Entrer votre email',
            TextInputType.emailAddress,
            Icon(
              Icons.email,
              color: Colors.grey[500],
            ),
            null,
            false,
            emailController),
        SizedBox(
          height: 10.0,
        ),
        /*  InputWidget(
            'Mot de passe',
            'Entrer votre mot de passe',
            TextInputType.text,
            Icon(
              Icons.lock,
              color: Colors.grey[500],
            ),
            IsHashedPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        IsHashedPassword = !IsHashedPassword;
                        passwordController.clear();
                      });
                    },
                    icon: Icon(Icons.visibility_off))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        IsHashedPassword = !IsHashedPassword;
                      });
                    },
                    icon: Icon(Icons.visibility)),
            IsHashedPassword,
            passwordController), */
        SizedBox(
          height: 10.0,
        ),
        InputWidget(
            'Adresse',
            'Entrer votre Adresse',
            TextInputType.text,
            Icon(
              Icons.home,
              color: Colors.grey[500],
            ),
            null,
            false,
            addressController),
        _saveBtn()
      ],
    );
  }

  bool _validateInputs() {
    if (fullNameController.text.isEmpty) return false;
    if (phoneController.text.length < 5) return false;
    if (emailController.text.length < 5 || !emailController.text.contains('@'))
      return false;
    if (addressController.text.length < 5) return false;
    return true;
  }

  void changeScreen() {
    setState(() {
      _isDataLoading = false;
    });
  }

  void _bottomPopupSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
              height: double.infinity,
              padding: EdgeInsets.only(top: 8.0),
              decoration: BoxDecoration(
                  color: Color(0x00FFFFFF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0))),
              child: Container(
                child: SpinKitRing(
                  color: Colors.blue,
                  size: 50.0,
                ),
              ));
        });
  }
}
