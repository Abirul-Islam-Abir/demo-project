import 'package:get/get.dart';

import '../modules/all_messages_by_chat_id/bindings/all_messages_by_chat_id_binding.dart';
import '../modules/all_messages_by_chat_id/views/all_messages_by_chat_id_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/create_event/bindings/create_event_binding.dart';
import '../modules/create_event/views/create_event_view.dart';
import '../modules/event_by_id/bindings/event_by_id_binding.dart';
import '../modules/event_by_id/views/event_by_id_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login_select/bindings/login_select_binding.dart';
import '../modules/login_select/views/login_select_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_SELECT,
      page: () => const LoginSelectView(),
      binding: LoginSelectBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_EVENT,
      page: () => const CreateEventView(),
      binding: CreateEventBinding(),
    ),
    GetPage(
      name: _Paths.EVENT_BY_ID,
      page: () => EventByIdView(),
      binding: EventByIdBinding(),
    ),
    GetPage(
      name: _Paths.ALL_MESSAGES_BY_CHAT_ID,
      page: () =>   AllMessagesByChatIdView(),
      binding: AllMessagesByChatIdBinding(),
    ),
  ];
}
