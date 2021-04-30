import 'package:http/http.dart' as http;
import 'package:proypet/config/global_variables.dart';
import 'package:proypet/source/notificaciones/model/notificacion_model.dart';

class NotificationProvider {
  final _url = urlApi;

  Future<NotificacionModel> getNotificacion() async {
    final url = Uri.parse('$_url/notifications');
    final resp = await http.get(
      url,
      headers: headersToken(),
    );

    NotificacionModel notificacionModel = notificacionModelFromJson(resp.body);

    notificacionModel.notifications.forEach((element) {
      element.message = '${element.message}';
    });
    return notificacionModel;
  }
}
