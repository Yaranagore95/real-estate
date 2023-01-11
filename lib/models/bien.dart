import 'dart:convert';

class Bien {
  int id;
  String numero;
  String latitude;
  String longitude;
  String adresse;
  int surface;

  String description;
  String type;
  String etatBien;
  String typeMaison;
  String usageMaison;
  int anneeConstruction;
  String usageAppartement;
  int nbrePiece;
  String typeDocument;

  Bien({
    required this.id,
    required this.numero,
    required this.latitude,
    required this.longitude,
    required this.adresse,
    required this.surface,
    required this.description,
    required this.type,
    required this.etatBien,
    required this.typeMaison,
    required this.usageMaison,
    required this.anneeConstruction,
    required this.usageAppartement,
    required this.nbrePiece,
    required this.typeDocument,
  });

  Bien copyWith({
    int? id,
    String? numero,
    String? latitude,
    String? longitude,
    String? adresse,
    int? surface,
    String? description,
  }) {
    return Bien(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      adresse: adresse ?? this.adresse,
      surface: surface ?? this.surface,
      description: description ?? this.description,
      type: type ?? this.type,
      etatBien: etatBien ?? this.etatBien,
      typeMaison: typeMaison ?? this.typeMaison,
      usageMaison: usageMaison ?? this.usageMaison,
      anneeConstruction: anneeConstruction ?? this.anneeConstruction,
      usageAppartement: usageAppartement ?? this.usageAppartement,
      nbrePiece: nbrePiece ?? this.nbrePiece,
      typeDocument: typeDocument ?? this.typeDocument,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero':
          numero,
      'latitude': latitude,
      'longitude': longitude,
      'adresse': adresse,
      'surface': surface,
      'description': description,
      'type': type,
      'etat_bien': etatBien,
      'type_maison': typeMaison,
      'usage_maison': usageMaison,
      'annee_construction': anneeConstruction,
      'usage_appartement': usageAppartement,
      'nbre_piece': nbrePiece,
      'type_document': typeDocument,
    };
  }

  factory Bien.fromMap(Map<String, dynamic> map) {
    return Bien(
        id: map['id'] as int,
        numero: map['numero']
            as String ,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      adresse: map['adresse'] as String,
      surface: map['surface'] as int,
      description: map['description'] as String,
      type: map['type'] as String,
      etatBien: map['etatBien'] as String,
      typeMaison: map['typeMaison'] as String,
      usageMaison: map['usageMaison'] as String,
      anneeConstruction: map['anneeConstruction'] as int,
      usageAppartement: map['usageAppartement'] as String,
      nbrePiece: map['nbrePiece'] as int,
      typeDocument: map['typeDocument'] as String,
        );
  }

  String toJson() => json.encode(toMap());

  factory Bien.fromJson(String source) =>
      Bien.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return "Bien"; /*'Bien(id: $id, numero: $numero, latitude: $latitude, longitude: $longitude, adresse: $adresse, surface: $surface, '
        'description: $description, type: $type, etatBien: $etatBien, typeMaison: $typeMaison, usageMaison: $usageMaison, '
        'anneeConstruction: $anneeConstruction, usageAppartement: $usageAppartement, nbrePiece: $nbrePiece, typeDocument: $typeDocument)';*/
  }

  @override
  bool operator ==(covariant Bien other) {
    if (identical(this, other)) return true;

    return other.id == id &&
            other.numero ==
                numero /* &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.adresse == adresse &&
        other.surface == surface&&
        other.description == description &&
        other.type == type &&
        other.etatBien == etatBien &&
        other.typeMaison == typeMaison &&
        other.usageMaison == usageMaison &&
        other.anneeConstruction == anneeConstruction &&
        other.usageAppartement == usageAppartement &&
        other.nbrePiece == nbrePiece &&
        other.typeDocument == typeDocument*/
        ;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numero.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        adresse.hashCode ^
        surface.hashCode ^
        description.hashCode ^
        type.hashCode ^
        etatBien.hashCode ^
        typeMaison.hashCode ^
        usageMaison.hashCode ^
        anneeConstruction.hashCode ^
        usageAppartement.hashCode ^
        nbrePiece.hashCode ^
        typeDocument.hashCode;
  }
}
