import 'package:flutter_showcase/core/types/type_defs.dart';
import 'package:flutter_showcase/features/links/links.dart';
import 'package:injectable/injectable.dart';

/// Repository implementation for handling links-related operations.
@Singleton(as: ILinksRepository)
class LinksRepository implements ILinksRepository {
  /// Constructor
  const LinksRepository(this._datasource);

  final LinksDatasource _datasource;

  @override
  StreamFailT<String> initAndListenLinks() {
    return _datasource.initAndListenLinks();
  }
}
