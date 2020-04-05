import 'package:flutter/material.dart';
import 'package:proypet/src/pages/shared/navigation_bar.dart';
import 'package:proypet/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:proypet/src/routes/routes.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final prefs = new PreferenciasUsuario();
    
    var rutaInicio='login';
    if(prefs.token!=''){
      rutaInicio='navInicio';
    }

    return MaterialApp(
      title: 'Proypet',
      theme: ThemeData( 
        fontFamily: 'PT Sans',
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,      
      routes: getRoutes(),
      initialRoute: rutaInicio,
      onGenerateRoute: (RouteSettings settings){
        return MaterialPageRoute(
          builder: (BuildContext context)=>NavigationBar(currentTabIndex: 0) //cuando falle
        );
      },      
    );
  }
}


    //var config = AppConfig.of(context);
    //config.appName,