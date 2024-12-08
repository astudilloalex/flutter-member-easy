import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:member_easy/app/middlewares/auth_middleware.dart';
import 'package:member_easy/src/attendance/application/attendance_service.dart';
import 'package:member_easy/src/attendance/domain/I_attendance_repository.dart';
import 'package:member_easy/src/attendance/infrastructure/firebase_attendance_repository.dart';
import 'package:member_easy/src/auth/application/auth_service.dart';
import 'package:member_easy/src/auth/domain/i_auth_repository.dart';
import 'package:member_easy/src/auth/infrastructure/firebase_auth_repository.dart';
import 'package:member_easy/src/company/application/company_service.dart';
import 'package:member_easy/src/company/domain/i_company_repository.dart';
import 'package:member_easy/src/company/infrastructure/firebase_company_repository.dart';
import 'package:member_easy/src/member/application/member_service.dart';
import 'package:member_easy/src/member/domain/i_member_repository.dart';
import 'package:member_easy/src/member/infrastructure/firebase_member_repository.dart';
import 'package:member_easy/src/membership/application/membership_service.dart';
import 'package:member_easy/src/membership/domain/i_membership_repository.dart';
import 'package:member_easy/src/membership/infrastructure/firebase_membership_repository.dart';
import 'package:member_easy/src/summary/application/summary_service.dart';
import 'package:member_easy/src/summary/domain/i_summary_repository.dart';
import 'package:member_easy/src/summary/infrastructure/firebase_summary_repository.dart';
import 'package:member_easy/src/user/application/user_service.dart';
import 'package:member_easy/src/user/domain/i_user_repository.dart';
import 'package:member_easy/src/user/infrastructure/firebase_user_repository.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  const Injection._();

  static void init() {
    // Declare repositories
    getIt.registerLazySingleton<IAttendanceRepository>(
      () => FirebaseAttendanceRepository(FirebaseFirestore.instance),
    );
    getIt.registerLazySingleton<IAuthRepository>(
      () => FirebaseAuthRepository(FirebaseAuth.instance),
    );
    getIt.registerLazySingleton<ICompanyRepository>(
      () => FirebaseCompanyRepository(FirebaseFirestore.instance),
    );
    getIt.registerLazySingleton<IMemberRepository>(
      () => FirebaseMemberRepository(FirebaseFirestore.instance),
    );
    getIt.registerLazySingleton<IMembershipRepository>(
      () => FirebaseMembershipRepository(FirebaseFirestore.instance),
    );
    getIt.registerLazySingleton<ISummaryRepository>(
      () => FirebaseSummaryRepository(FirebaseFirestore.instance),
    );
    getIt.registerLazySingleton<IUserRepository>(
      () => FirebaseUserRepository(FirebaseFirestore.instance),
    );

    // Declare services
    getIt.registerFactory<AttendanceService>(
      () => AttendanceService(
        getIt<IAttendanceRepository>(),
      ),
    );
    getIt.registerFactory<AuthService>(
      () => AuthService(
        getIt<IAuthRepository>(),
        userRepository: getIt<IUserRepository>(),
      ),
    );
    getIt.registerFactory<CompanyService>(
      () => CompanyService(getIt<ICompanyRepository>()),
    );
    getIt.registerFactory<MemberService>(
      () => MemberService(getIt<IMemberRepository>()),
    );
    getIt.registerFactory<MembershipService>(
      () => MembershipService(getIt<IMembershipRepository>()),
    );
    getIt.registerFactory<SummaryService>(
      () => SummaryService(getIt<ISummaryRepository>()),
    );
    getIt.registerFactory<UserService>(
      () => UserService(getIt<IUserRepository>()),
    );

    // Declare middlewares
    getIt.registerFactory<AuthMiddleware>(
      () => AuthMiddleware(getIt<AuthService>()),
    );
  }
}
