import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/core/extensions/extensions.dart';
import 'package:flutter_showcase/features/sign_up/sign_up.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sign_up_cubit.freezed.dart';
part 'sign_up_state.dart';

/// A Cubit that manages the state of the Sign Up page.
@injectable
class SignUpCubit extends Cubit<SignUpState> {
  /// constructor
  SignUpCubit(this._signUpUserEmail) : super(SignUpState.initial());

  final SignUpUserEmail _signUpUserEmail;

  /// on set name
  void onSetName(String name) => emit(state.copyWith(name: name));

  /// on set email
  void onSetEmail(String email) => emit(state.copyWith(email: EmailAddress(email)));

  /// on set password
  void onSetPassword(String password) {
    emit(
      state.copyWith(
        password: Password(password, confirmPassword: state.confirmPassword.getOrNull),
      ),
    );
  }

  /// on set confirm password
  void onSetConfirmPassword(String confirmPassword) {
    emit(
      state.copyWith(
        confirmPassword: ConfirmPassword(confirmPassword, password: state.password.getOrNull),
      ),
    );
  }

  /// Sign Up the user with email and password.
  Future<void> signUpUserEmail() async {
    emit(state.copyWith(isProcessing: true));

    if (!state.email.isValid || !state.password.isValid || state.name.isEmpty) {
      addError('Name, Email, Password and ConfirmPassword must be valid!');
      emit(state.copyWith(isProcessing: false));
      return;
    }

    final dto = EmailSignUpDto(
      email: state.email.getOrCrash,
      password: state.password.getOrCrash,
      name: state.name,
    );
    final res = await _signUpUserEmail(dto);

    if (res.isLeft()) addError(res.asL);

    emit(state.copyWith(isProcessing: false, result: res));
  }
}
