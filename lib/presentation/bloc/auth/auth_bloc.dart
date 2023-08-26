import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_auth/data/models/auth.dart';
import 'package:test_auth/data/repositorys/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository repository;


  AuthBloc(this.repository) : super(Initial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is SignIn) {
          emit(Loading());
          final model = await repository.logIn(
            event.username,
            event.password,
          );
          if(model is AutogeneratedModel){
            emit(Authenticated(model: model));
          } else {
            emit(ErrorState(message: model.toString()));
          }
        }
      },
    );
  }
}

