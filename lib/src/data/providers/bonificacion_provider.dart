import 'package:http/http.dart' as http;
import 'package:proypet/config/global_variables.dart';
import 'package:proypet/src/data/models/model/bonificacion/bonificacion_model.dart';

class BonificacionProvider {
  final _url = urlApi;

  Future<BonificacionModel> getBonificacion() async {
    final url = '$_url/bonifications';

    final resp = await http.get(url, headers: headersToken());

    BonificacionModel bonificacion = bonificacionModelFromJson(resp.body);
    return bonificacion;
  }
}
