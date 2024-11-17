import 'package:member_easy/src/company/domain/company.dart';

abstract class ICompanyRepository {
  const ICompanyRepository();

  Future<List<Company>> findByOwnerCode(String ownerCode);
}
