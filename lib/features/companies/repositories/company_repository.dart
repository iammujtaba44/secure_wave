import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:secure_wave/core/services/database_service/i_database_service.dart';
import 'package:secure_wave/core/services/locator_service.dart';
import 'package:secure_wave/features/companies/models/companies_model.dart';

abstract class ICompanyRepository {
  Future<List<Companies>> getCompanies();
}

class CompanyRepository implements ICompanyRepository {
  final IDatabaseService _database = locator.get();

  @override
  Future<List<Companies>> getCompanies() async {
    try {
      final event = await _database.getData('companies/data');

      final Map<dynamic, dynamic> data = event as Map<dynamic, dynamic>;

      final companies = data.entries.map((entry) {
        final company = entry.value as Map<dynamic, dynamic>;
        return Companies(
          companyId: company['companyId'] ?? '',
          branchId: company['branchId'] ?? '',
          companyName: company['companyName'] ?? '',
          branchName: company['branchName'] ?? '',
        );
      }).toList();

      return companies;
    } catch (e) {
      throw Exception('Failed to fetch companies: $e');
    }
  }
}
