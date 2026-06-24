import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/errors/failures.dart';
import 'package:flutter_showcase/core/extensions/extensions.dart';
import 'package:flutter_showcase/features/profile/profile.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'profile_coins_state.dart';

part 'profile_coins_cubit.freezed.dart';

/// Cubit class for managing the state of profile coins.
@injectable
class ProfileCoinsCubit extends Cubit<ProfileCoinsState> {
  /// Constructor
  ProfileCoinsCubit(this._watchProfileCoins) : super(ProfileCoinsState.initial()) {
    watchProfileCoins();
  }

  final WatchProfileCoins _watchProfileCoins;

  StreamSubscription<Either<Failure, double>>? _stream;

  /// Fetches the profile coins and updates the state accordingly.
  void watchProfileCoins() {
    _stream = _watchProfileCoins().listen((res) {
      if (res.isLeft()) {
        emit(state.copyWith(error: res.asL.toString()));
        return addError(res.asL);
      }

      emit(state.copyWith(coins: res.asR));
    });
  }

  @override
  Future<void> close() async {
    await _stream?.cancel();
    return super.close();
  }
}
