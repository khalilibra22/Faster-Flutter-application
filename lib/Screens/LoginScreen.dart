import 'dart:io';
import 'package:Faster/Screens/splashScreen.dart';
import 'package:Faster/classes/mSystem.dart';
import 'package:Faster/config/CustomToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'configuration.dart';
import '../Animations/FadeAnimation.dart';
import 'SignupScreen.dart';
import 'package:toast/toast.dart';
import 'LoadingScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool PasswordVisbility = true;
  bool isLoading = true;
  final EmailController = TextEditingController();
  final PasswordCottroller = TextEditingController();
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: EmailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Entrer votre email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Mot de passe',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: PasswordCottroller,
            obscureText: PasswordVisbility,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              suffixIcon: PasswordVisbility
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          PasswordVisbility = !PasswordVisbility;
                        });
                      },
                      icon: Icon(Icons.visibility_off))
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          PasswordVisbility = !PasswordVisbility;
                        });
                      },
                      icon: Icon(Icons.visibility)),
              hintText: 'Entrer votre mot de passe',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Mot de passe oublier?'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Mot de passe oublier?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (!InputsValidate()) return;
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoadingWidget()));

          int isUser = await mSystemLocator()
              .UserLogin(EmailController.text, PasswordCottroller.text);
          if (isUser == 200)
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LaunchScreen()));
          else {
            Navigator.of(context).pop();
            if (isUser == 404)
              mToast().errorMessage('Email ou mot de passe incoreecte');

            if (isUser == 400) return;
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'CONNEXION',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat-bold',
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignupScreen()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Vous n'avez pas de compte? ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: "S'incrire",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontFamily: 'Montserrat-bold',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF73AEF5),
                        Color(0xFF61A4F1),
                        Color(0xFF478DE0),
                        Color(0xFF398AE5),
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FadeAnimation(
                          1,
                          Text(
                            'Connexion',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontSize: 30.0,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        FadeAnimation(1.1, _buildEmailTF()),
                        SizedBox(
                          height: 30.0,
                        ),
                        FadeAnimation(1.2, _buildPasswordTF()),
                        //FadeAnimation(1.3, _buildForgotPasswordBtn()),
                        SizedBox(
                          height: 10.0,
                        ),
                        FadeAnimation(1.4, _buildLoginBtn()),
                        FadeAnimation(1.5, _buildSignupBtn()),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool InputsValidate() {
    if (EmailController.text.isEmpty || PasswordCottroller.text.isEmpty) {
      Toast.show('Remplir les champs', context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
          backgroundColor: Color(0xAABF3D69));
      return false;
    }
    if (EmailController.text.length < 5 ||
        !EmailController.text.contains('@')) {
      Toast.show('Vérifier votre email', context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
          backgroundColor: Color(0xAABF3D69));
      return false;
    }
    if (PasswordCottroller.text.length < 6) {
      Toast.show('Mot de passe +6 charactere', context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
          backgroundColor: Color(0xAABF3D69));
      return false;
    }

    return true;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Etes-vous sûr ?',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                fontFamily: 'Montserrat-bold',
                letterSpacing: 1,
              ),
            ),
            content: new Text(
              'Voulez-vous vraiment quitter ?',
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.black,
                fontFamily: 'Montserrat-bold',
                letterSpacing: 0,
              ),
            ),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  "NO",
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.red[400],
                    fontFamily: 'Montserrat-bold',
                    letterSpacing: 1,
                  ),
                ),
              ),
              SizedBox(height: 10),
              new GestureDetector(
                onTap: () => exit(0) /* Navigator.of(context).pop(true) */,
                child: Text(
                  "OUI   ",
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.blue,
                    fontFamily: 'Montserrat-bold',
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
