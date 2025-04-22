class Companies {
  final String branchId;
  final String branchName;
  final String companyId;
  final String companyName;

  Companies({
    required this.branchId,
    required this.branchName,
    required this.companyId,
    required this.companyName,
  });

  factory Companies.fromMap(Map<String, dynamic> map) {
    return Companies(
      branchId: map['branchId'] as String,
      branchName: map['branchName'] as String,
      companyId: map['companyId'] as String,
      companyName: map['companyName'] as String,
    );
  }

  // Convert the Companies instance to a map
  Map<String, dynamic> toMap() {
    return {
      'branchId': branchId,
      'branchName': branchName,
      'companyId': companyId,
      'companyName': companyName,
    };
  }

  Companies copyWith({
    String? branchId,
    String? branchName,
    String? companyId,
    String? companyName,
  }) {
    return Companies(
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
    );
  }
}
