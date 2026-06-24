import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/links/links.dart';
import 'package:injectable/injectable.dart';

/// Usecase to initialize [deep-links] and [app-links]
@singleton
class InitializeLinks implements UsecaseStreamNoParams<String> {
  /// Constructor
  const InitializeLinks(this._repository);

  final ILinksRepository _repository;

  @override
  StreamFailT<String> call() {
    return _repository.initAndListenLinks();
  }
}
