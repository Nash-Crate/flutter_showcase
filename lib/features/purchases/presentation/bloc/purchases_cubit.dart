import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/purchases/purchases.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'purchases_cubit.freezed.dart';
part 'purchases_cubit_state.dart';

/// Manages the general purchases features
@singleton
class PurchasesCubit extends Cubit<PurchasesState> {
  /// constructor
  PurchasesCubit(this._initializePurchases) : super(PurchasesState.initial()) {
    unawaited(initialize());
  }

  final InitializePurchases _initializePurchases;

  /// Initializes the purchases
  Future<void> initialize() async {
    final res = await _initializePurchases();
    if (res.isLeft()) return addError(res.asL);
  }
}
