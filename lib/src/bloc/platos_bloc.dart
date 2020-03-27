
import 'dart:io';
import 'dart:async';
import 'package:cooking_at_home/src/bloc/validators.dart';
import 'package:rxdart/subjects.dart';

import 'package:cooking_at_home/src/models/platos_models.dart';
export 'package:cooking_at_home/src/models/platos_models.dart';
import 'package:cooking_at_home/src/providers/plato_provider.dart';

class PlatosBloc with Validators{
  /**
   * tendremos dos streams 
   * 1) para manejar el listado completo de platos (para cuando se inserte o se haga una modificación, para volverlos a cargar)
   * 2) para trabajar caundo se esta subiendo información 
   */
  final _platosControlle = new BehaviorSubject<List<PlatoModel>>();
  final _cargandoControlle = new BehaviorSubject<bool>();

  // Referencia a platosProvaiders 
  final _platoProvider = new PlatosProvider();

  // Escuchando lo que salga del Stream
  // Retorna un Streams que resuelve una lista de platosModel con la Desayuno
  Stream<List<PlatoModel>> get platoDesayunoStream => _platosControlle.stream.transform(validarDesayuno);
  // Retorna un Streams que resuelve una lista de platosModel con la Almuerzo
  Stream<List<PlatoModel>> get platoAlmuerzoStream => _platosControlle.stream.transform(validarTipoAlmuerzo);
  // Retorna un Streams que resuelve una lista de platosModel con la cena
  Stream<List<PlatoModel>> get platoCenaStream => _platosControlle.stream.transform(validarTipoCena);
  // Retorna un Strams que resuelve una booleano
  Stream<bool> get cargandoStream => _cargandoControlle.stream;
  
  /// Metodos para cargar los platos en el stream
  void obtenerPlatos() async {
    final platos = await _platoProvider.getPlatos();
    /* mandando la informacion al Stream */
    _platosControlle.sink.add(platos); 
  }
  /// Metodo para agregar un nuevo plato
  void agregarPlato(PlatoModel plato) async {
    _cargandoControlle.sink.add(true);
    //TODO: falta agregar la imagen del plato
    await _platoProvider.crearPlato(plato);
    _cargandoControlle.sink.add(false);

  }
  /// Metodo para subir una imagen del plato
  Future<String> subirImagen(File refImagen) async {
    _cargandoControlle.sink.add(true);
    final imagenUrl = await _platoProvider.subirImagen(refImagen);
    _cargandoControlle.sink.add(false);
  }
  // Eliminar imagen
  Future<void> eliminarImg(String url) async {
    await _platoProvider.deleteImage(url);
  }

  /// Metodo para editar un plato
  void editarPlato(PlatoModel plato) async {
     _cargandoControlle.sink.add(true);
    //TODO: falta la imagen del plato
    await _platoProvider.editPlato(plato);
    _cargandoControlle.sink.add(false);  
  }
  /// Metodo para eliminar un plato
  void eliminarPlato(PlatoModel plato) async {
     _cargandoControlle.sink.add(true);
    //TODO: falta la imagen del plato
    await _platoProvider.deletePlato(id:plato.id);
    _cargandoControlle.sink.add(false);
  }

  // Para cerrar los Stream
  dispose(){
    _platosControlle?.close();
    _cargandoControlle?.close();
  }

}