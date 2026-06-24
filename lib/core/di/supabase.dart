import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// External library injection for Supabase related dependencies.
@module
abstract class SupbasePersistenceExternalLibraryInjectableModule {
  /// Injects SupabaseClient instance for database interactions.
  @preResolve
  Future<SupabaseClient> supabase() async {
    await Supabase.initialize(
      url: const String.fromEnvironment('SUPABASE_URL'),
      publishableKey: const String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY'),
    );

    return Supabase.instance.client;
  }
}
