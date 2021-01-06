import 'package:shared_preferences/shared_preferences.dart';

class Data {
  String id;

  String Name;
  String Email;
  String Mobile;
  String photoUrl;
  String current_level;
  String current_score;

  Data(
      {this.id,
      this.Name,
      this.Mobile,
      this.photoUrl,
      this.current_level,
      this.current_score,
      this.Email});
}

class GetPrefData {
  List<Data> data;
  String _pId;
  String _email;
  String _name;
  String _photoUrl;
  String _currentLevel;
  String _currentScore;
  String _mobial;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _pId = preferences.getString("id");
    _email = preferences.getString("email");
    _name = preferences.getString("name");
    _photoUrl = preferences.getString("photoUrl");
    _currentLevel = preferences.getString("Completed_level");
    _currentScore = preferences.getString("Score");
    _mobial = preferences.getString("Score");
    data.add(Data(
      id: _pId,
      Name: _name,
      Mobile: _mobial,
      photoUrl: _photoUrl,
      Email: _email,
      current_level: _currentLevel,
      current_score: _currentScore,
    ));

    return data;
  }
}
