import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/src/features/features.dart';
import 'package:flutter_ebook_app/src/router/app_router.dart';
import 'package:flutter_ebook_app/src/theme/theme_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sembast/sembast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage();
  await DatabaseConfig.init(StoreRef<dynamic, dynamic>.main());
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAppTheme = ref.watch(currentAppThemeNotifierProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: themeData(
        currentAppTheme.value == CurrentAppTheme.dark
            ? ThemeConfig.darkTheme
            : ThemeConfig.lightTheme,
      ),
      darkTheme: themeData(ThemeConfig.darkTheme),
      themeMode: currentAppTheme.value?.themeMode,
      routerConfig: _appRouter.config(),
    );
  }

  // Apply font to our app's theme
  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.sourceSansProTextTheme(
        theme.textTheme,
      ),
      colorScheme: theme.colorScheme.copyWith(
        secondary: ThemeConfig.lightAccent,
      ),
    );
  }
}
