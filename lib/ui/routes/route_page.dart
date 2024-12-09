import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:member_easy/app/bloc/app_cubit.dart';
import 'package:member_easy/app/middlewares/auth_middleware.dart';
import 'package:member_easy/injection.dart';
import 'package:member_easy/src/attendance/application/attendance_service.dart';
import 'package:member_easy/src/auth/application/auth_service.dart';
import 'package:member_easy/src/company/application/company_service.dart';
import 'package:member_easy/src/member/application/member_service.dart';
import 'package:member_easy/src/summary/application/summary_service.dart';
import 'package:member_easy/src/user/application/user_service.dart';
import 'package:member_easy/ui/pages/add_edit_member/add_edit_member_page.dart';
import 'package:member_easy/ui/pages/add_edit_member/bloc/add_edit_member_cubit.dart';
import 'package:member_easy/ui/pages/company/bloc/company_cubit.dart';
import 'package:member_easy/ui/pages/company/company_page.dart';
import 'package:member_easy/ui/pages/home/bloc/home_cubit.dart';
import 'package:member_easy/ui/pages/home/home_page.dart';
import 'package:member_easy/ui/pages/member/bloc/member_cubit.dart';
import 'package:member_easy/ui/pages/member/member_page.dart';
import 'package:member_easy/ui/pages/member_detail/bloc/member_detail_cubit.dart';
import 'package:member_easy/ui/pages/member_detail/member_detail_page.dart';
import 'package:member_easy/ui/pages/sign_in/bloc/sign_in_cubit.dart';
import 'package:member_easy/ui/pages/sign_in/sign_in_page.dart';
import 'package:member_easy/ui/pages/sign_up/bloc/sign_up_cubit.dart';
import 'package:member_easy/ui/pages/sign_up/sign_up_page.dart';
import 'package:member_easy/ui/pages/splash/bloc/splash_cubit.dart';
import 'package:member_easy/ui/pages/splash/splash_page.dart';
import 'package:member_easy/ui/routes/route_name.dart';

class RoutePage {
  const RoutePage({
    required this.authMiddleware,
  });

  final AuthMiddleware authMiddleware;

  GoRouter get router {
    return GoRouter(
      initialLocation: RouteName.splash,
      redirect: (context, state) {
        context.read<AppCubit>().updateCurrentUser(authMiddleware.currentUser);
        if (!authMiddleware.loggedIn) {
          if (state.matchedLocation == RouteName.signIn ||
              state.matchedLocation == RouteName.splash ||
              state.matchedLocation == RouteName.signUp) {
            return null;
          }
          return RouteName.signIn;
        }
        return null;
      },
      refreshListenable: authMiddleware,
      routes: [
        GoRoute(
          path: RouteName.addEditMember,
          builder: (context, state) {
            final Map<String, String> parameters = state.uri.queryParameters;
            final String? memberCode = parameters['code'];
            return BlocProvider(
              create: (context) => AddEditMemberCubit(
                company: context.read<AppCubit>().state.currentCompany,
                memberService: getIt<MemberService>(),
                userService: getIt<UserService>(),
                memberCode: memberCode,
              ),
              child: const AddEditMemberPage(),
            );
          },
        ),
        GoRoute(
          path: RouteName.company,
          builder: (context, state) => BlocProvider(
            create: (context) => CompanyCubit(
              companyService: getIt<CompanyService>(),
              currentUser: context.read<AppCubit>().state.currentUser!,
            ),
            child: const CompanyPage(),
          ),
        ),
        GoRoute(
          path: RouteName.home,
          builder: (context, state) => BlocProvider(
            create: (context) => HomeCubit(
              companyService: getIt<CompanyService>(),
              currentUser: context.read<AppCubit>().state.currentUser!,
              summaryService: getIt<SummaryService>(),
            ),
            child: const HomePage(),
          ),
        ),
        GoRoute(
          path: RouteName.member,
          builder: (context, state) => BlocProvider(
            create: (context) => MemberCubit(
              memberService: getIt<MemberService>(),
              attendanceService: getIt<AttendanceService>(),
            ),
            child: const MemberPage(),
          ),
        ),
        GoRoute(
          path: '${RouteName.memberDetail}/:memberCode',
          builder: (context, state) => BlocProvider(
            create: (context) => MemberDetailCubit(
              memberService: getIt<MemberService>(),
              attendanceService: getIt<AttendanceService>(),
              memberCode: state.pathParameters['memberCode']!,
            ),
            child: const MemberDetailPage(),
          ),
        ),
        GoRoute(
          path: RouteName.signIn,
          builder: (context, state) => BlocProvider(
            create: (context) => SignInCubit(
              authService: getIt<AuthService>(),
            ),
            child: const SignInPage(),
          ),
        ),
        GoRoute(
          path: RouteName.signUp,
          builder: (context, state) => BlocProvider(
            create: (context) => SignUpCubit(
              authService: getIt<AuthService>(),
            ),
            child: const SignUpPage(),
          ),
        ),
        GoRoute(
          path: RouteName.splash,
          builder: (context, state) => BlocProvider(
            create: (context) => SplashCubit(
              authService: getIt<AuthService>(),
              companyService: getIt<CompanyService>(),
            ),
            child: const SplashPage(),
          ),
        ),
      ],
    );
  }
}
