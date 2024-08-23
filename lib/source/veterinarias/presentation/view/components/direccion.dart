import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/config/variables_globales.dart';
import 'package:proypet/source/veterinarias/data/model/address.dart';
import 'package:proypet/source/veterinarias/domain/controller/filtra_vets_controller.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';
import 'package:http/http.dart' as http;

final filtroC = Get.find<FiltraVetsController>();

autocompleteAddress() {
  return SimpleAutocompleteFormField<Prediction2>(
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.location_on),
      hintText: 'Ingrese dirección',
    ),
    maxSuggestions: 3,
    onSearch: (filter) async {
      var response = await http.get(
        Uri.parse(
            "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=$keyMap&language=es&input=$filter"),
      );
      var models = addressFromJson(response.body);

      return models.predictions;
    },
    minSearchLength: 2,
    onChanged: (Prediction2 data) =>
        (data != null) ? filtroC.gpsDireccion(data) : null,
    resetIcon: null,
    itemBuilder: (context, address) => Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Text(address.name, style: TextStyle(fontWeight: FontWeight.bold)),
    ),
  );
}