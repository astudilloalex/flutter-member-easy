import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/member/domain/i_member_repository.dart';
import 'package:member_easy/src/member/domain/member.dart';
import 'package:member_easy/src/member/infrastructure/member_mapper.dart';

class FirebaseMemberRepository implements IMemberRepository {
  const FirebaseMemberRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<List<Member>> findByCompanyCode(
    String companyCode, {
    Member? lastMember,
    int limit = 25,
  }) async {
    final Query<Map<String, dynamic>> query = lastMember == null
        ? _firestore
            .collection('companies')
            .doc(companyCode)
            .collection('members')
            .orderBy('fullName')
            .limit(limit)
        : _firestore
            .collection('companies')
            .doc(companyCode)
            .collection('members')
            .orderBy('fullName')
            .startAfter([lastMember.fullName]).limit(limit);
    final QuerySnapshot<Map<String, dynamic>> data = await query.get();
    return data.docs.map(
      (document) {
        return MemberMapper.fromFirestore(document);
      },
    ).toList();
  }

  @override
  Future<Either<Failure, Member>> save(
    Member member, {
    required String companyCode,
  }) async {
    final QuerySnapshot<Map<String, dynamic>> data = await _firestore
        .collection('companies')
        .doc(companyCode)
        .collection('members')
        .where(
          'idCard',
          isEqualTo: member.idCard,
        )
        .limit(1)
        .get();
    if (data.docs.isNotEmpty) {
      return const Left(
        FirebaseFailure(
          failureEnum: FailureEnum.thereAlreadyMemberWithThatID,
        ),
      );
    }
    final DocumentReference<Map<String, dynamic>> doc = await _firestore
        .collection('companies')
        .doc(companyCode)
        .collection('members')
        .add(MemberMapper.toJson(member));
    return Right(member.copyWith(code: doc.id));
  }

  @override
  Future<Either<Failure, Member>> update(
    Member member, {
    required String companyCode,
  }) async {
    final DocumentSnapshot<Map<String, dynamic>> document = await _firestore
        .collection('companies')
        .doc(companyCode)
        .collection('members')
        .doc(member.code)
        .get();
    if (!document.exists) {
      return const Left(
        FirebaseFailure(failureEnum: FailureEnum.theMemberDoesNotExist),
      );
    }
    final Member savedMember = MemberMapper.fromFirestoreDocument(document);
    await _firestore
        .collection('companies')
        .doc(companyCode)
        .collection('members')
        .doc(member.code)
        .update(
          MemberMapper.toJson(member.copyWith(idCard: savedMember.idCard)),
        );
    return Right(member.copyWith(idCard: savedMember.idCard));
  }
}
