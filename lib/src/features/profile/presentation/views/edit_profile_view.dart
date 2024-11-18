import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../cubit/edit_profile/edit_profile_cubit.dart';

import '../components/edit_profile_form.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: AppStrings.editProfile,
            iconright: Icons.arrow_forward_ios,
            onPressedRight: () => GoRouter.of(context).pop(),
          ),
          BlocProvider(
            create: (context) => getIt<EditProfileCubit>(),
            child: const EditProfileForm(),
          ),
        ],
      ),
    );
  }
}
