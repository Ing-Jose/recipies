import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

import 'package:cooking_at_home/src/models/platos_models.dart';
export 'package:cooking_at_home/src/models/platos_models.dart';

/// Encardado de hacer las interaciones directa con la DB
class PlatosProvider {
  final String _url = 'https://foots-654f5.firebaseio.com/'; // url de la base de datos  


  Future<bool> crearPlato(PlatoModel plato) async {
    // TODO: cambia a futuro el id de usuario aswedfress ponerlo dinamico
    final url ='$_url/user/aswedfress/platos.json';
    final resp= await http.post(url,body: platoModelToJson(plato));
    final decodeData = json.decode(resp.body);
    print(decodeData);

    return true;
  }
  /// metodo que retorna una lista de todos los platos 
  Future<List<PlatoModel>> getPlatos() async {
    List<PlatoModel> platos = List();
    final url ='$_url/user/aswedfress/platos.json';
    final resp = await http.get(url);
    // decodeData es un mapa
    final Map<String,dynamic> decodeData = json.decode(resp.body);

    if(decodeData==null) return []; // sino hay datos en la DB

    // recorriendo el decodeData por cada uno de los id
    decodeData.forEach((id,plato){
      // print(plato);
      final PlatoModel platoTemp = PlatoModel.fromJson(plato);
      platoTemp.id = id;

      platos.add(platoTemp);
    });
    // print(platos);
    return platos;
  }
  /// Metodo para eliminar un producto
  Future<bool> deletePlato({@required String id}) async {
    final url ='$_url/user/aswedfress/platos/$id.json';

    final resp = await http.delete(url);
    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }
  /// Editar un plato
  Future<int> editPlato(PlatoModel plato) async {
    final url='$_url/user/aswedfress/platos/${plato.id}.json';
    final resp = await http.put(url,body: platoModelToJson(plato));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return 1;
  }
  /// Retorna un Future de tipo String con la Url de la imagen que se le paso como referencia 
  Future<String> subirImagen(File imagen) async {
    if (imagen!=null) {
      var imageName = Uuid().v1();
      //TODO: Cambiar el id de usuario aswedfress
      var imagePath = 'users/aswedfress/$imageName.jpg';
      // ruta dentro de nuestro storage donde queremos guardar la imagen a subir 
      final StorageReference storageReference = FirebaseStorage().ref().child(imagePath);
      // Tarea que se encarga de subir el archivo
      final StorageUploadTask uploadTask = storageReference.putFile(imagen);
      // suscripcion a la tarea 
      final StreamSubscription<StorageTaskEvent> streamSubscription = uploadTask.events.listen((event) {
        // You can use this to notify yourself or your user in any kind of way.
        // For example: you could use the uploadTask.events stream in a StreamBuilder instead
        // to show your user what the current status is. In that case, you would not need to cancel any
        // subscription as StreamBuilder handles this automatically.
        // Here, every StorageTaskEvent concerning the upload is printed to the logs.
        print('EVENT ${event.type}');
      });
      // Cancel your subscription when done.

      streamSubscription.cancel();
      await uploadTask.onComplete;

      /** 2 */
      // actualizando el registro guardado,
      // pasando y se mezcla con el ya existente en ves de sobre escribirlo
      final resp = await storageReference.getDownloadURL();
      // print(resp);
      return resp.toString();
    
    }    
    return null;
  }


  Future<void> deleteImage(String imageFileUrl) async {
    var fileUrl = Uri.decodeFull(Path.basename(imageFileUrl)).replaceAll(new RegExp(r'(\?alt).*'), '');
    // print(fileUrl);
    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileUrl);
      //print(firebaseStorageRef);
      await firebaseStorageRef.delete();
  }

} 