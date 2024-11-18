import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/common/widgets/custom_text_form_field.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../doctorprofile/cubit/note/note_cubit.dart';

class PharmacyAddDetailsWidget extends StatelessWidget {
  PharmacyAddDetailsWidget(
      {super.key,
      required this.details,
      required this.onPressed,
      this.noteController});
  TextEditingController? noteController = TextEditingController();
  final String details;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
      ),
      child: BlocListener<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is NoteLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Note Sent successfully!'),
              ),
            );
            GoRouter.of(context).pop();
          } else if (state is NoteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error.message}')),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              details,
              style: AppStyles.s20.copyWith(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 17.h,
            ),
            CustomTextFormField(
              hintText: AppStrings.addYourDetails,
              maxLines: 2,
              controller: noteController,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomButton(
                borderRadius: BorderRadius.circular(
                  2,
                ),
                width: 143.w,
                height: 28.h,
                text: AppStrings.saveDetails,
                textStyle: AppStyles.s14.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
