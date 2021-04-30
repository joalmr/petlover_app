import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:proypet/config/global_variables.dart';
import 'package:proypet/source/mascota/model/pet_model.dart';

class MascotaProvider {
  final _url = urlApi;

  Future<Map<String, dynamic>> savePet(
      MascotaModel2 mascota, File imagen) async {
    final url = Uri.parse('$_url/pets');

    final data = {
      'name': mascota.name,
      'birthdate': mascota.birthdate, //datetime
      'specie': mascota.specieId.toString(), //int
      'breed': mascota.breedId.toString(), //int
      'genre': mascota.genre.toString(), //int
    };

    final resp = await http.post(url, headers: headersToken(), body: data);

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      final Map<String, dynamic> decodedResp = json.decode(resp.body);
      final idkey = decodedResp['pet']['id'];
      final urlpet = '$_url/pets/$idkey/base64';

      String petImg = "$urlName/img/favicon.png";
      if (imagen.path != '') {
        petImg = await upImage(imagen, urlpet);
      }

      return {'ok': true, 'petImg': petImg};
    } else
      return {'ok': false, 'petImg': ''};
  }

  Future<bool> editPet(MascotaModel2 mascota, File imagen) async {
    final idkey = mascota.id;
    final urlpet = '$_url/pets/$idkey/base64';

    if (imagen.path != '') {
      upImage(imagen, urlpet);
    }

    final url = Uri.parse('$_url/pets/$idkey');

    final data = {
      'name': mascota.name,
      'birthdate': mascota.birthdate, //datetime
      'specie': mascota.specieId.toString(), //int
      'breed': mascota.breedId.toString(), //int
      'genre': mascota.genre.toString(), //int
    };

    final resp = await http.post(url, headers: headersToken(), body: data);

    if (resp.statusCode == 200)
      return true;
    else
      return false;
  }

  Future<String> upImage(File imagen, String url) async {
    final imageBytes = imagen.readAsBytesSync();
    final pic = base64.encode(imageBytes);
    final mimetype = mime(imagen.path).split('/');
    final part0 = mimetype[0];
    final part1 = mimetype[1];

    String sendPic = 'data:$part0/$part1;base64,$pic';

    var img = await http.post(
      Uri.parse(url),
      headers: headersToken(),
      body: {'base64': sendPic},
    );

    var decodeimg = json.decode(img.body);

    return decodeimg["picture"];
  }
}
