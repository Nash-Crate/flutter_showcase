import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/links/links.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'links_state.dart';

part 'links_cubit.freezed.dart';

/// Cubit to manage the state of links feature
@singleton
class LinksCubit extends Cubit<LinksState> {
  /// Constructor
  LinksCubit(this._initializeLinks) : super(const LinksState.initial()) {
    _init();
  }

  final InitializeLinks _initializeLinks;

  void _init() {
    _initializeLinks().listen(
      (res) async {
        if (res.isLeft()) return addError(res.asL);

        emit(NewLinkCaptured(res.asR));

        // add a delay and reset the state
        await Future<void>.delayed(const Duration(milliseconds: 2000));
        emit(const LinksState.initial());
      },
    );
  }
}
