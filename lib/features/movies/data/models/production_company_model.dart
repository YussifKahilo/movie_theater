import '../../domain/entities/production_company.dart';

class ProductionCompanyModel extends ProductionCompany {
  ProductionCompanyModel(
      {required super.id, required super.logoPath, required super.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'logoPath': logoPath,
      'name': name,
    };
  }

  factory ProductionCompanyModel.fromMap(Map<String, dynamic> map) {
    return ProductionCompanyModel(
      id: map['id'],
      logoPath: map['logo_path'],
      name: map['name'],
    );
  }
}
