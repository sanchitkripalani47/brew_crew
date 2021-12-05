class UserData {
  final String uid;

  UserData ({required this.uid});
}

class UserPreferences {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserPreferences ( {required this.uid, required this.name,
    required this.sugars, required this.strength} );
}