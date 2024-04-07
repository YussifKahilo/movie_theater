import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/config/routes/routes.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/spacer.dart';
import 'package:movie_theater/core/manager/values_manager.dart';
import 'package:movie_theater/core/widgets/custom_container.dart';
import 'package:movie_theater/core/widgets/custom_text.dart';
import 'package:movie_theater/features/auth/presentation/cubit/auth_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          current is GetUserFailedState ||
          current is GetUserLoadingState ||
          current is GetUserSuccessState,
      builder: (context, state) {
        if (state is GetUserSuccessState) {
          return Column();
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                'You have to login to access this page',
              ),
              AppSize.s30.spaceH,
              CustomContainer(
                onTap: () => Navigator.pushNamed(context, Routes.loginScreen),
                haveShadows: true,
                padding: (PaddingValues.p10, PaddingValues.p80).pSymmetricVH,
                text: 'Login',
              ),
              AppSize.s100.spaceH,
            ],
          );
        }
      },
    );
  }
}
