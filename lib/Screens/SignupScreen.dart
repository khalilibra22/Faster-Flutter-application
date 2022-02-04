import 'package:Faster/Screens/LoadingScreen.dart';
import 'package:Faster/Screens/NoConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'configuration.dart';
import '../config/CustomToast.dart';
import '../Animations/FadeAnimation.dart';
import 'LoginScreen.dart';
import '../classes/mSystem.dart';

class SignupScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  bool PasswordVisbility = true;
  final EmailController = TextEditingController();
  final PhoneController = TextEditingController();
  final PasswordController = TextEditingController();
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

  Widget _buildPhoneTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'N° Téléphone',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: PhoneController,
            keyboardType: TextInputType.phone,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone_android,
                color: Colors.white,
              ),
              hintText: 'Entrer votre N° téléphone',
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
            controller: PasswordController,
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

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (!_InputsValidation()) return;
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoadingWidget()));
          int checkEmail =
              await mSystemLocator().checkEmail(EmailController.text);
          if (checkEmail != 200) {
            if (checkEmail == 404) {
              mToast().infoMessage('Changer votre email');
              Navigator.of(context).pop();
              return;
            }

            if (checkEmail == 400)
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NoConnection()));
          } else {
            bool isRegistred = await mSystemLocator().CreateNewUser(
                null,
                PhoneController.text,
                EmailController.text,
                PasswordController.text);
            if (!isRegistred) {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NoConnection()));
              //mToast().infoMessage('try again !!');
            } else
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          "INSCRIPTION",
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
        Navigator.pop(context);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "J'ai un compte | ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: "Se connecter",
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
    return Scaffold(
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
                          "S'incrire",
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
                      FadeAnimation(1.2, _buildPhoneTF()),
                      SizedBox(
                        height: 30.0,
                      ),
                      FadeAnimation(1.3, _buildPasswordTF()),
                      SizedBox(
                        height: 15.0,
                      ),
                      //FadeAnimation(1.4, _buildForgotPasswordBtn()),
                      FadeAnimation(1.5, _buildLoginBtn()),
                      FadeAnimation(1.6, _buildSignupBtn()),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _InputsValidation() {
    if (EmailController.text.isEmpty ||
        PhoneController.text.isEmpty ||
        PasswordController.text.isEmpty) {
      mToast().errorMessage('Champs vides !!');

      return false;
    }
    if (!EmailController.text.contains('@') ||
        EmailController.text.length < 5) {
      mToast().errorMessage('Vérifier votre email');

      return false;
    }
    if (PhoneController.text.length < 5) {
      mToast().errorMessage('Vérifier votre N° téléphone');
      return false;
    }
    if (PasswordController.text.length < 5) {
      mToast().errorMessage('Mot de passe trés court');

      return false;
    }
    return true;
  }
}
