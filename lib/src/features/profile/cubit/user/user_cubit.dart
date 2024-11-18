import 'package:bloc/bloc.dart';
import '../../../../../core/errors/error_model.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/repos/user_repo_abstract.dart';
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
