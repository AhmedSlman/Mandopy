import 'package:bloc/bloc.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/auth/data/models/user_model.dart';
import 'package:mandopy/src/features/profile/data/repos/user_repo_abstract.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepoAbstract userRepoAbstract;
  UserCubit(this.userRepoAbstract) : super(UserInitial());

  Future<void> getUserModel() async {
    emit(UserLoading());

   
    final userModel = await userRepoAbstract.getUserModel();
    
    userModel.fold(
      (error) => emit(UserError(error)),
      (userModelResponse) {
        emit(UserLoaded(userModelResponse));
      },
    );
  }
}
