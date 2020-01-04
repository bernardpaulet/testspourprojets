

class User {
  String numUser;
  String nom;
  String prenom;
  String message;

  User({this.numUser, this.nom, this.prenom, this.message});

  User.fromJson(Map<String, dynamic> data)
      : numUser = data['NumUser'],
        nom = data['Nom'],
        prenom = data['Prenom'],
        message = data['message'];
}