import 'package:secure_wave/features/companies/models/companies_model.dart';
import 'package:secure_wave/features/companies/repositories/company_repository.dart';

class GetCompaniesUseCase {
  final ICompanyRepository _repository;

  GetCompaniesUseCase(this._repository);

  Future<List<Companies>> execute() async {
    try {
      return await _repository.getCompanies();
    } catch (e) {
      throw Exception('Failed to get companies: $e');
    }
  }
}
