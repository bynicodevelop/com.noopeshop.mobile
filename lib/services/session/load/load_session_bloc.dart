import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shop/entities/session_entity.dart";
import "package:shop/repositories/session_repository.dart";

part "load_session_event.dart";
part "load_session_state.dart";

class LoadSessionBloc extends Bloc<LoadSessionEvent, LoadSessionState> {
  late SessionRepository sessionRepository;

  LoadSessionBloc(
    this.sessionRepository,
  ) : super(LoadSessionInitialState()) {
    on<OnLoadSessionEvent>((event, emit) async {
      emit(LoadSessionLoadingState());

      try {
        final SessionEntity session = await sessionRepository.getSession();

        emit(LoadSessionSuccessState(
          session,
        ));
      } catch (e) {
        emit(LoadSessionFailureState(
          e.toString(),
        ));
      }
    });
  }
}
