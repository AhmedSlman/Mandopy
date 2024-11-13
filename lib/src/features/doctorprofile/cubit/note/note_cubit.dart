// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/doctorprofile/data/models/note_model.dart';
import 'package:mandopy/src/features/doctorprofile/data/repos/doctor_repo_abstract.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final DoctorRepoAbstract doctorRepoAbstract;
  NoteCubit(this.doctorRepoAbstract) : super(NoteInitial());

  Future<void> addANote({required String id, required String note}) async {
    emit(NoteLoading());

    final result = await doctorRepoAbstract.addANote(id: id, note: note);
    result.fold(
      (error) => emit(NoteError(error)),
      (noteResponse) => emit(
        NoteLoaded(noteResponse),
      ),
    );
  }
}
