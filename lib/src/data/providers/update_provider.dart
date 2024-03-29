import 'package:dio/dio.dart';
import 'package:package_info/package_info.dart';
import 'package:proypet/config/global_variables.dart';

class UpdateProvider {
  final _url = urlApi;
  Dio dio = new Dio();

  Future<bool> setAppAndroid() async {
    final url = '$_url/version/android';

    Response response = await dio.get(url);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    print("==update android==");
    print(response.statusCode);
    print("==instalado ${packageInfo.buildNumber}==");
    print("==servicio ${response.data['versionCode']}==");

    int buildNumber = int.parse(packageInfo.buildNumber);
    int versionCode = int.parse(response.data['versionCode']);

    versionAndroid = response.data['versionName'];

    if (buildNumber < versionCode) {
      return true;
    }
    return false;
  }

  Future<bool> setAppiOs() async {
    final url = '$_url/version/ios';

    Response response = await dio.get(url);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    print("==update ios==");
    print(response.statusCode);
    print("==instalado ${packageInfo.buildNumber}==");
    print("==servicio ${response.data['versionCode']}==");

    int buildNumber = int.parse(packageInfo.buildNumber);
    int versionCode = int.parse(response.data['versionCode']);

    versionIOS = response.data['versionName'];

    if (buildNumber < versionCode) {
      return true;
    }
    return false;
  }
}
