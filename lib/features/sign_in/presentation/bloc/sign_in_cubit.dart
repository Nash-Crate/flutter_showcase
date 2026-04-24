import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/core/extensions/extensions.dart';
import 'package:flutter_showcase/features/sign_in/sign_in.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_state.dart';

part 'sign_in_cubit.freezed.dart';

/// Cubit for managing the state of the sign-in process.
@injectable
class SignInCubit extends Cubit<SignInState> {
  /// constructor
  SignInCubit(this._signInUserGoogle, this._signInUserEmail) : super(SignInState.initial());

  final SignInUserEmail _signInUserEmail;
  final SignInUserGoogle _signInUserGoogle;

  /// Logs in the user with email and password.
  Future<void> loginUserEmail() async {
    emit(state.copyWith(isProcessing: true));

    if (!state.email.isValid || !state.password.isValid) {
      addError('Email and password must be valid!');
      emit(state.copyWith(isProcessing: false));
      return;
    }

    final dto = EmailSignInDto(
      email: state.email.getOrCrash,
      password: state.password.getOrCrash,
    );
    final res = await _signInUserEmail(dto);
    if (res.isLeft()) addError(res.asL);

    emit(state.copyWith(isProcessing: false, result: res));
  }

  /// Logs in the user with Google.
  Future<void> loginUserGoogle() async {
    emit(state.copyWith(isProcessing: true));

    final res = await _signInUserGoogle();
    if (res.isLeft()) addError(res.asL);

    emit(state.copyWith(isProcessing: false, result: res));
  }

  /// on set email
  void onSetEmail(String email) => emit(state.copyWith(email: EmailAddress(email)));

  /// on set password
  void onSetPassword(String password) => emit(state.copyWith(password: Password(password)));
}
