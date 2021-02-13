import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/src/data/services/auth/auth_service.dart';

final authService = AuthService();
errorInesperado() {
  showDialog(
    context: Get.context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(20),
        content: Text('Debes volver a iniciar sesión 🐶🐱'),
      );
    },
  );
  Timer(Duration(milliseconds: 3500), () => authService.outToken());
}

// Widget errorInternet() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       SizedBox(height: 10.0),
//       Text("La conexión a internet es débil"),
//       Center(
//         child: Image(
//             height: 300,
//             width: 300,
//             image: AssetImage("images/gato-error.png")),
//       ),
//     ],
//   );
// }

// Widget errorMessage(String mensaje) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       SizedBox(height: 10.0),
//       Text(mensaje),
//       Center(
//         child: Image(
//             height: 200,
//             width: 200,
//             image: AssetImage("images/gato-error.png")),
//       ),
//     ],
//   );
// }
