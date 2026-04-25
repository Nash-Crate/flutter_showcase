import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

part 'home_cubit.freezed.dart';

/// The HomeCubit manages the state of the home page.
@injectable
class HomeCubit extends Cubit<HomeState> {
  /// Constructor
  HomeCubit() : super(HomeState.initial());
}
