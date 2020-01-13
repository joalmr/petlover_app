import 'package:flutter/material.dart';
import 'package:proypet/src/pages/home_page.dart';
// import 'package:proypet/src/pages/login_page.dart';
import 'package:proypet/src/routes/routes.dart';
 
void main() => runApp(MyApp());

final colorMain = Colors.green;
final colorSec = Color.fromRGBO(125, 35, 75, 1);


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proypet',
      debugShowCheckedModeBanner: false,
      routes: getRoutes(),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings){
        return MaterialPageRoute(
          builder: (BuildContext context)=>HomePage(), //cuando falle
        );
      },      
    );
  }
}
