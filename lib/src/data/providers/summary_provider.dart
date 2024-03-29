import 'package:proypet/config/global_variables.dart';
import 'package:proypet/src/data/models/model/home_model.dart';
import 'package:http/http.dart' as http;

class SummaryProvider {
  final _url = urlApi;

  Future<HomeModel> getUserSummary() async {
    final url = '$_url/summary';

    final resp = await http.get(url, headers: headersToken());
    HomeModel homeModel = homeModelFromJson(resp.body);

    return homeModel;
  }
}
