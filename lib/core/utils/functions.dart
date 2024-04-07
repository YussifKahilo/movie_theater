import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_theater/features/auth/presentation/cubit/auth_cubit.dart';

import '../../src/injection_container.dart';
import '../api/api_consumer.dart';
import '../widgets/loading.dart';

double getScreenHeight() =>
    ScreenUtil().screenHeight -
    ScreenUtil().statusBarHeight -
    getAppBarHeight();

double getAppBarHeight() => AppBar().preferredSize.height;

void cancelCurrentRequest() => diInstance<ApiConsumer>().cancelRequest();

Color getColorFromHex(String hex) =>
    Color(int.parse('0xff${hex.replaceAll('#', '')}'));

void showLoadingDialog(context) => showDialog(
      context: context,
      builder: (context) => const LoadingDialog(),
    );

bool isUserLoggedIn(context) =>
    AuthCubit.get(context).state is GetUserSuccessState;
