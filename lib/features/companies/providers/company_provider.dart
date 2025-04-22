import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:secure_wave/features/companies/models/companies_model.dart';
import 'package:secure_wave/features/companies/usecases/get_companies_usecase.dart';

class CompanyProvider extends ChangeNotifier {
  final GetCompaniesUseCase _getCompaniesUseCase;

  CompanyProvider(this._getCompaniesUseCase);

  List<Companies> _companies = [];
  bool _isLoading = false;
  String? _error;

  List<Companies> get companies => _companies;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadCompanies() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _companies = await _getCompaniesUseCase.execute();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
