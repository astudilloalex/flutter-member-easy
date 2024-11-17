import 'package:member_easy/src/summary/domain/summary.dart';

abstract class ISummaryRepository {
  const ISummaryRepository();

  Future<List<Summary>> findByCompanyCode(String companyCode);
}
