import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class UpdatePreferences extends StatefulWidget {
  const UpdatePreferences({Key? key}) : super(key: key);

  @override
  _UpdatePreferencesState createState() => _UpdatePreferencesState();
}

class _UpdatePreferencesState extends State<UpdatePreferences> {

  // Form Keys
  final _formKeys = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName = 'New Member';
  String _currentSugars = '';
  int _currentStrength = 100;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserData?>(context);

    return StreamBuilder<UserPreferences>(
      stream: DatabaseService(uid: user!.uid).userPreferences,
      builder: (context, snapshot) {
        if (snapshot.hasData){

          UserPreferences? preferences = snapshot.data;

          return Form(
            key: _formKeys,
            child: Column(
              children: <Widget>[
                const Text(
                  'Update Your Preferences',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: preferences!.name,
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Please Enter a name': null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField(
                  value: preferences.sugars,
                  decoration: textInputDecoration,
                  onChanged: (val) {
                    setState(() => _currentSugars = val.toString());
                  },
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      child: Text("$sugar sugars"),
                      value: sugar,
                    );
                  }).toList(),
                ),


                Slider(
                  value: _currentStrength != 100 ? _currentStrength.toDouble() : preferences.strength.toDouble(),
                  onChanged: (val) => setState(() => _currentStrength = val.round()),
                  activeColor: Colors.brown[_currentStrength == 100 ? preferences.strength : _currentStrength],
                  inactiveColor: Colors.brown[_currentStrength == 100 ? preferences.strength : _currentStrength],
                  min: 100,
                  max: 900,
                  divisions: 8,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink[400]
                  ),
                  onPressed: () async {
                    if (_formKeys.currentState!.validate()) {
                      print(_currentName);
                      print(_currentSugars);
                      print(_currentStrength);
                      print('');
                      print(preferences.name);
                      print(preferences.sugars);
                      print(preferences.strength);
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentName != 'New Member' ? _currentName : preferences.name,
                          _currentSugars == '' ? preferences.sugars : _currentSugars,
                          _currentStrength == 100 ? preferences.strength : _currentStrength
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

              ],
            ),
          );
        }

        else {
          return Loading();
        }


      }
    );
  }
}
