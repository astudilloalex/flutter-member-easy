import 'package:member_easy/src/membership/domain/membership.dart';

abstract class IMembershipRepository {
  const IMembershipRepository();

  Future<List<Membership>> findByCompanyCode(String companyCode);
}
