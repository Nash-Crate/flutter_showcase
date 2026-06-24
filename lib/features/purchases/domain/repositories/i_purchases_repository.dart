import 'package:flutter_showcase/core/types/type_defs.dart';
import 'package:fpdart/fpdart.dart';

/// The IPurchasesRepository defines the contract for the purchasing system
mixin IPurchasesRepository {
  /// Initializes the purchasing system.
  AsyncFailT<Unit> initializePurchasing();
}
