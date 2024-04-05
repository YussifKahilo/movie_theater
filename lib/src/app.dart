import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_theater/features/movies/domain/entities/movie.dart';
import 'package:movie_theater/features/movies/presentation/cubit/movies_cubit.dart';
import '../config/routes/routes.dart';
import '../config/routes/routes_manager.dart';
import '../config/theme/themes_manager.dart';
import '../core/features/theme/presentation/cubit/theme_cubit.dart';
import '../core/manager/strings_manager.dart';
import 'injection_container.dart';

class MyApp extends StatelessWidget {
  final double? designWidth;
  final double? designHeight;
  const MyApp({
    Key? key,
    this.designWidth,
    this.designHeight,
  }) : super(key: key);

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(
              getSavedThemeUseCase: diInstance(),
              changeThemeUseCase: diInstance())
            ..getSavedTheme(),
        ),
        BlocProvider(
          create: (context) => MoviesCubit(diInstance())
            ..getMoviesList(MovieSection.upComing)
            ..getMoviesList(MovieSection.topRated),
        )
      ],
      child: ScreenUtilInit(
        designSize: Size(designWidth ?? 428, designHeight ?? 926),
        splitScreenMode: true,
        builder: (context, child) => child!,
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Builder(builder: (context) {
              final themeState = context.watch<ThemeCubit>().state;

              return MaterialApp(
                darkTheme: Themes.getDarkTheme(),
                theme: Themes.getLightTheme(),
                themeMode: themeState,
                debugShowCheckedModeBanner: false,
                title: StringsManager.appName,
                navigatorKey: navigatorKey,
                initialRoute: Routes.splashScreen,
                onGenerateRoute: RoutesManager.generateRoute,
              );
            })),
      ),
    );
  }
}
