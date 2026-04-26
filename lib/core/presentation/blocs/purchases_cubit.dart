import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'purchases_cubit.freezed.dart';
part 'purchases_cubit_state.dart';

/// Manages the general purchease features
@singleton
class PurchasesCubit extends Cubit<PurchasesState> {
  /// constructor
  PurchasesCubit(this._initializePurchases, this._getUserCoins) : super(PurchasesState.initial()) {
    unawaited(initialize());
    unawaited(getUserCoins());
  }

  final InitializePurchases _initializePurchases;
  final GetUserCoins _getUserCoins;

  /// Initializes the purchases
  Future<void> initialize() async {
    final res = await _initializePurchases();
    if (res.isLeft()) return addError(res.asL);
  }

  /// Fetches the user's coins
  Future<void> getUserCoins() async {
    final res = await _getUserCoins();

    if (res.isLeft()) return addError(res.asL);

    emit(state.copyWith(userCoins: res.asR));
  }
}
