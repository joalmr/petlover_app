import 'package:flutter/material.dart';
import 'package:proypet/src/utils/ddl_opciones.dart';
import 'package:proypet/src/app/styles/styles.dart';

Widget ddlMain(context, opcionSeleccionada, lista, cambiaOpc) {
  return Material(
    elevation: 0.0,
    shape: shape10,
    color: Theme.of(context).backgroundColor,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            dropdownColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.keyboard_arrow_down, color: colorMain),
            isExpanded: true,
            value: opcionSeleccionada,
            items: getOpcionesDropdown(lista),
            onChanged: cambiaOpc),
      ),
    ),
  );
}

Widget ddlMainOut(context, opcionSeleccionada, lista, cambiaOpc, String deshabilitado) {
  return Material(
    elevation: 0.0,
    shape: shape10,
    color: Theme.of(context).backgroundColor,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            dropdownColor: Theme.of(context).backgroundColor,
            disabledHint: Text(deshabilitado),
            icon: Icon(Icons.keyboard_arrow_down, color: colorMain),
            isExpanded: true,
            value: opcionSeleccionada,
            items: getOpcionesDropdown(lista),
            onChanged: cambiaOpc),
      ),
    ),
  );
}

Widget ddlFutureImg(context, opcionSeleccionada, lista, cambiaOpc) {
  return Material(
    elevation: 0.0,
    shape: shape10,
    color: Theme.of(context).backgroundColor,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            dropdownColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.keyboard_arrow_down, color: colorMain),
            isExpanded: true,
            value: opcionSeleccionada,
            items: getOpcionesImgFuture(lista),
            onChanged: cambiaOpc),
      ),
    ),
  );
}

// Widget ddlFutureSearch(context, opcionSeleccionada, lista, cambiaOpc){
//   try{
//     return Material(
//       // borderRadius: borderRadius,
//       shape: shape10,
//       color: Theme.of(context).backgroundColor, //Colors.grey[200],
//       elevation: 0.0,
//       child: SearchableDropdown.single(
//         icon: Icon(Icons.keyboard_arrow_down,color: colorMain),
//         hint: "Seleccione raza",
//         searchHint: "Seleccione raza",
//         items: getOpcionesSearch(lista),
//         value: opcionSeleccionada,
//         onChanged: cambiaOpc,
//         isExpanded: true,
//         closeButton: null,
//         displayClearIcon: false,
//         underline: "",
//       ),
//     );
//   }
//   catch(ex){
//     return LinearProgressIndicator();
//   }
// }
