import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/core/utils/service_locator.dart';
import 'package:store_app/features/auth/data/repos/login_repo/login_repo_impl.dart';
import 'package:store_app/features/auth/data/repos/register_repo/register_repo_impl.dart';
import 'package:store_app/features/auth/presentation/view_models/cubits/login_cubit/login_cubit.dart';
import 'package:store_app/features/auth/presentation/view_models/cubits/register_cubit/register_cubit.dart';
import 'package:store_app/features/auth/presentation/views/login_view/login_view.dart';
import 'package:store_app/features/auth/presentation/views/register_view/register_view.dart';
import 'package:store_app/features/cart/data/models/get_cart_models/get_cart_response.dart';
import 'package:store_app/features/cart/data/repos/cart_repo/cart_repo_impl.dart';
import 'package:store_app/features/cart/presentation/view_models/cart_cubit/cart_cubit.dart';
import 'package:store_app/features/cart/presentation/views/cart_view/cart_view.dart';
import 'package:store_app/features/home/data/repos/details_repo/details_repo_impl.dart';
import 'package:store_app/features/home/data/repos/home_repo/home_repo_impl.dart';
import 'package:store_app/features/home/presentation/views/details_view/details_view.dart';
import 'package:store_app/features/home/presentation/views/home_view/home_view.dart';
import 'package:store_app/features/home/presentation/view_models/details_cubit/details_cubit.dart';
import 'package:store_app/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:store_app/features/on_boarding/presentation/view_model/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:store_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:store_app/features/settings/data/repos/settings_repo/settings_repo_impl.dart';
import 'package:store_app/features/settings/presentation/view_models/settings_cubit/settings_cubit.dart';
import 'package:store_app/features/settings/presentation/views/edit_profile_view/edit_profile_view.dart';

abstract class AppRouter {
  static const kOnBoardingView = '/onboarding';
  static String kLoginView = token == null ? '/' : '/login';
  static String kHomeView = token != null ? '/' : '/home';
  static const kDetailsView = '/details';
  static const kRegisterView = '/reg';
  static const kEditProfileView = '/edit';
  static const kCartView = '/cartView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kOnBoardingView,
        builder: (context, state) => BlocProvider(
          create: (context) => OnBoardingCubit(),
          child: const OnBoardingView(),
        ),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(getIt.get<LoginRepoImpl>()),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => BlocProvider(
          create: (context) => RegisterCubit(getIt.get<RegisterRepoImpl>()),
          child: const RegisterView(),
        ),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              HomeCubit(getIt.get<HomeRepoImpl>())..getHomeData(),
          child: const HomeView(),
        ),
      ),
      GoRoute(
        path: kDetailsView,
        builder: (context, state) => BlocProvider(
          create: (context) => DetailsCubit(getIt.get<DetailsRepoImpl>())
            ..getProductDetails(state.extra as int),
          child: const DetailsView(),
        ),
      ),
      GoRoute(
        path: kEditProfileView,
        builder: (context, state) => BlocProvider(
            create: (context) =>
                SettingsCubit(getIt.get<SettingsRepoImpl>()),
            child: const EditProfileView()),
      ),
      GoRoute(
          path: kCartView,
          builder: (context, state) => BlocProvider(
                create: (context) =>
                    CartCubit(getIt.get<CartRepoImpl>())..getCart(),
                child: CartView(cartResponse: state.extra as GetCartResponse),
              )),
    ],
  );
}
