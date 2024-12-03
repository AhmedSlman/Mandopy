part of 'note_cubit.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteLoading extends NoteState {}

final class NoteLoaded extends NoteState {
  final NoteModel noteModel;

  NoteLoaded(this.noteModel);
}

final class NoteError extends NoteState {
  final ErrorModel error;

  NoteError(this.error);
}
