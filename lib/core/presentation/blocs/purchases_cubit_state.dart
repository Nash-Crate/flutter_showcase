part of 'purchases_cubit.dart';

/// State of the [PurchasesCubit]
@freezed
abstract class PurchasesState with _$PurchasesState {
  /// constructor
  const factory PurchasesState({double? userCoins}) = _PurchasesState;

  ///initial state
  factory PurchasesState.initial() => const PurchasesState();
}
