import 'package:movie_theater/features/movies/data/models/production_company_model.dart';

class ProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
  });

  ProductionCompanyModel toDomain() =>
      ProductionCompanyModel(id: id, logoPath: logoPath, name: name);
}
