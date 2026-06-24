import 'package:app_links/app_links.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/links/links.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Datasource for handling links-related operations.
abstract class LinksDatasource with ILinksRepository {}

/// Implementation of [LinksDatasource] for handling links-related operations.
@Singleton(as: LinksDatasource)
class LinksDatasourceImpl implements LinksDatasource {
  /// constructor
  const LinksDatasourceImpl(this._appLinks);

  final AppLinks _appLinks;

  @override
  StreamFailT<String> initAndListenLinks() async* {
    try {
      // uriLinkStream emits both the cold-start (initial) link and any links
      // received while the app is running.
      await for (final uri in _appLinks.uriLinkStream) {
        yield Right(uri.toString());
      }
    } on Exception catch (e) {
      yield Left(InfraExceptions.exceptionToFailure(e));
    }
  }
}
