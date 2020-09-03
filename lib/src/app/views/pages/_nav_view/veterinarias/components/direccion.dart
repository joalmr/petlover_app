import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/config/global_variables.dart';
import 'package:proypet/src/controllers/veterinaria_controller/filtra_vets_controller.dart';
import 'package:proypet/src/data/models/model/maps/address.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

import 'package:http/http.dart' as http;

String searchAddr = "";
final filtroC = Get.find<FiltraVetsController>();

autocompleteAddress() {
  return SimpleAutocompleteFormField<Prediction2>(
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.location_on),
      hintText: 'Ingrese una dirección',
    ),
    maxSuggestions: 3,
    initialValue: (filtroC.dataDireccion != null) ? filtroC.dataDireccion : null,
    onSearch: (filter) async {
      var response = await http.get("https://maps.googleapis.com/maps/api/place/autocomplete/json?key=$keyMap&language=es&input=$filter");
      var models = addressFromJson(response.body);

      return models.predictions;
    },
    minSearchLength: 2,
    onChanged: (Prediction2 data) => (data != null) ? filtroC.gpsDireccion(data) : null,
    resetIcon: null,
    itemBuilder: (context, address) => Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Text(address.name, style: TextStyle(fontWeight: FontWeight.bold)),
    ),
  );
}
