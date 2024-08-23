import 'package:http/http.dart' as http;
import 'package:proypet/config/variables_globales.dart';

class PetDeadProvider {
  final _url = urlApi;

  /* Post */
  Future<bool> muerePet(String idMascota) async {
    final url = Uri.parse('$_url/pets/$idMascota/decease');

    final response = await http.post(url, headers: headersToken());

    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  /* Post */
  Future<bool> revivePet(String idMascota) async {
    final url = Uri.parse('$_url/pets/$idMascota/revive');
    final response = await http.post(url, headers: headersToken());

    if (response.statusCode == 200)
      return true;
    else
      return false;
  }
}