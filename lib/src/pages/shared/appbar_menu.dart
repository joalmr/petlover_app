import 'package:flutter/material.dart';
import 'package:proypet/src/pages/shared/styles/styles.dart';

//double size=55.0;

Widget appbar( logo, String texto, List<Widget> acc){
  return AppBar(
    backgroundColor: colorMain,
    leading: logo,
    title: Text(texto, style: TextStyle(fontSize: 18.0,),),
    actions: acc,
  );
}

Widget appbar2(titulo,acc,btnTab){
  return AppBar(
    backgroundColor: colorMain,
    leading: leadingH,
    title: titulo,
    actions: acc,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(25),
      child: btnTab,
    ),
  );
  // PreferredSize appbar =  PreferredSize(
  //   preferredSize: Size.fromHeight(80),
  //   child: AppBar(
  //     backgroundColor: colorMain,
  //     leading: inn,
  //     title: titulo,
  //     actions: acc,
  //     bottom: btnTab,
  //   )
  // );
  // return appbar;
}

final leadingH = Container(
  margin: EdgeInsets.all(.5),
  child: ClipRRect(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Center(child: Image(image: AssetImage('images/proypet.png'))),
    ),
  )
);

final titleH = "Proypet";

final actionsH = <Widget>[
  IconButton(
    icon: Icon(Icons.widgets),
    onPressed: (){},
  )
];
