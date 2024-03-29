import 'package:proypet/config/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:proypet/src/data/models/attention/atencion_model.dart';

class AttentionProvider {
  final _url = urlApi;

  Future<List<AtencionModel>> getAtenciones() async {
    final url = '$_url/attentions';

    final resp = await http.get(
      url,
      headers: headersToken(),
    );

    List<AtencionModel> atenciones = atencionModelFromJson(resp.body);
    atenciones = atenciones.where((x) => x.stars == null).toList();
    return atenciones;
  }

  Future<bool> calificar(AtencionModel atencion) async {
    final url = '$_url/attentions/${atencion.attentionId}/rate';

    final bodyData = {
      "stars": atencion.stars.toString(),
      "comment": atencion.comment,
    };

    final resp = await http.post(url, headers: headersToken(), body: bodyData);

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
