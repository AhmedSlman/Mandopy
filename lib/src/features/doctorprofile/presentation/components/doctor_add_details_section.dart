// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/common/widgets/custom_text_form_field.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../cubit/note/note_cubit.dart';

class DoctorAddDetailsSection extends StatefulWidget {
  final String doctorId;
  const DoctorAddDetailsSection({
    super.key,
    required this.doctorId,
  });

  @override
  State<DoctorAddDetailsSection> createState() =>
      _DoctorAddDetailsSectionState();
}

class _DoctorAddDetailsSectionState extends State<DoctorAddDetailsSection> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteCubit, NoteState>(
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
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 32.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.details,
              style: AppStyles.s20.copyWith(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 17.h,
            ),
            CustomTextFormField(
              controller: _noteController,
              hintText: AppStrings.addYourDetails,
              maxLines: 2,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomButton(
                borderRadius: BorderRadius.circular(2),
                width: 143.w,
                height: 28.h,
                text: AppStrings.saveDetails,
                textStyle: AppStyles.s14.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                onPressed: () {
                  final noteText = _noteController.text;
                  if (noteText.isNotEmpty) {
                    context.read<NoteCubit>().addANote(
                          id: widget.doctorId,
                          note: noteText,
                        );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a note')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
