import 'package:mobile_app_pilar/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class UserService {
  static const String _baseUrl = 'https://app.pilarsolusi.co.id/administrasi/api/dataUser.php?';

  Future getUser() async {
    Uri urlApi = Uri.parse(_baseUrl);

    final res = await http.get(urlApi);

    if (res.statusCode == 200){
      return userModelFromJson(res.body.toString());
    } else {
      print('Failed to load data User!');
      throw Exception("Failed to load data User!");
    }
  }
}