import 'dart:async';

import 'package:cooking_at_home/src/models/platos_models.dart';

// import 'package:cooking_at_home/src/providers/plato_provider.dart';

class Validators {
  /// Filtra los platos por tipo desayuno
  final validarDesayuno = StreamTransformer<List<PlatoModel>,List<PlatoModel>>.fromHandlers(
    handleData: (platos,sink){
      final plato = platos.where((p) => p.categoria == 'Desayuno').toList();
      sink.add(plato);
    }
  );
  /// Filtra los platos por tipo Almuerzo
  final validarTipoAlmuerzo = StreamTransformer<List<PlatoModel>,List<PlatoModel>>.fromHandlers(
    handleData: (platos,sink){
      final plato = platos.where((p) => p.categoria == 'Almuerzo').toList();
      sink.add(plato);
    }
  );
  /// Filtra los platos por tipo Cena
  final validarTipoCena = StreamTransformer<List<PlatoModel>,List<PlatoModel>>.fromHandlers(
    handleData: (platos,sink){
      final plato = platos.where((p) => p.categoria == 'Cena').toList();
      sink.add(plato);
    }
  );
}