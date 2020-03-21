// To parse this JSON data, do
//
//     final foot = footFromJson(jsonString);

import 'dart:convert';
/// Este metodo necesita el json en formato de Strin y retorna objeto Foot
PlatoModel platoModelFromJson(String str) => PlatoModel.fromJson(json.decode(str));
/// Convirtiendo el un modelos un json que sea string 
String platoModelToJson(PlatoModel data) => json.encode(data.toJson());
/**
 * Clase para moldear un plato con los siguientes atributos:
 * * String `id` 
 * * String `plato`
 * * String `descripcion`
 * * String `notas`
 * * String `fotoUrl`
 * * String `categoria`
 * * int `clasificacion`
 * * bool `blocked` 
 */
class PlatoModel {
    String id;
    String plato = '';
    String descripcion = '';
    String notas;
    String fotoUrl;
    String categoria ='';
    int clasificacion;
    bool blocked;

    PlatoModel({
        this.id,
        this.plato,
        this.descripcion,
        this.notas,
        this.fotoUrl,
        this.categoria,
        this.clasificacion,
        this.blocked,
    });
    /// Funcion que llamamos cuando queremos generar una instancia de Foot que viene de un mapa de formato Json
    /// Pero para no tener que acceder al map directamente descualquier parte de nuestra aplicación 
    /// que requiera serializar un Json, creamos un constructor con nombre (método estático) en la 
    /// clase Foot que realice el proceso, recibe como parámetro:  
    /// * Map<String, dynamic> `json` Map de tipo String, dynamic 
    /// 
    /// retorna un Objeto de tipo Plato
    factory PlatoModel.fromJson(Map<String, dynamic> json) => PlatoModel(
        id: json["id"],
        plato: json["Plato"],
        descripcion: json["descripcion"],
        notas: json["notas"],
        fotoUrl: json["fotoUrl"],
        categoria: json["categoria"],
        clasificacion: json["clasificacion"],
        blocked: json["blocked"],
    );
    /// Retorna un mapa 
    Map<String, dynamic> toJson() => {
        // "id": id,
        "Plato": plato,
        "descripcion": descripcion,
        "notas": notas,
        "fotoUrl": fotoUrl,
        "categoria": categoria,
        "clasificacion": clasificacion,
        "blocked": blocked,
    };
    // retorna la url de los platos en caso que no tenga imagen retorna una imagen local
    getUrlImagen(){
      if(fotoUrl==null) {
        return 'https://image.shutterstock.com/image-vector/picture-vector-icon-no-image-260nw-1514905736.jpg';
      } else{
        return fotoUrl;
      }
      
    }
}
/// clase que permite recibir un json con todos los platos de la bd y
/// los convierte en una lista 
class Platos {
  List<PlatoModel> platos = List();
  /// constructor
  Platos();
  Platos.fromJsonList(List<dynamic> jsonList){
    if (jsonList==null) return;

    for (final item in jsonList) {
      final PlatoModel foot = PlatoModel.fromJson(item);
      // print(foot);
      platos.add(foot);
    }
  }
}
