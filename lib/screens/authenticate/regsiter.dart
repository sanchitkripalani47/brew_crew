import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register({required this.toggleView});

  // const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  // Input from user
  String email = '';
  String password = '';

  // Global key form
  final _formKey = GlobalKey<FormState>();

  // Error Message
  String errorMessage = '';

  // Whether to load or not
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return load ? Loading() : Scaffold (
      backgroundColor: Colors.brown[100],

      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: const Text('Sign Up For Brew Crew'),
        elevation: 0,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: const Icon(Icons.person),
            label: const Text('Sign In'),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => email.isEmpty ? 'Enter an Email' : null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) => password.length < 6 ? 'Password should have atleast 6 characters ' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),

                SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()){
                      setState(() => load = true);
                      dynamic result = await _auth.registerWithEmail(email, password);

                      if (result == null){
                        setState(() {
                          errorMessage = 'Please enter a valid Email';
                          load = false;
                        });
                      }
                    }
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 14.0),
                Text(
                    errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
