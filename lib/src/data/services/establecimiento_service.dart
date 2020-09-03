import 'package:proypet/src/data/models/model/establecimiento/comentarios_model.dart';
import 'package:proypet/src/data/providers/establecimiento_provider.dart';

class EstablecimientoService {
  final EstablecimientoProvider establecimientoProvider = EstablecimientoProvider();

  getVets(dynamic filtros) {
    return establecimientoProvider.getVets(filtros);
  }

  getVet(String idVet) {
    return establecimientoProvider.getVet(idVet);
  }

  Future<List<Comentarios>> getComents(String idVet) {
    return establecimientoProvider.getComents(idVet);
  }
}
