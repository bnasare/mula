import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mula/shared/presentation/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'core/api/theme_mode_provider.dart';
import 'injection_container.dart' as di;
import 'l10n/app_localizations.dart';
import 'shared/presentation/widgets/restart_widget.dart';
import 'shared/utils/connectivity.dart';
import 'shared/utils/modal_visiblity.dart';
import 'src/dashboard/presentation/interface/screens/dashboard_screen.dart';
import 'src/onboarding/presentation/bloc/onboarding_mixin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await di.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
          ChangeNotifierProvider(create: (_) => ModalVisibleProvider()),
        ],
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with OnboardingMixin {
  Future<bool>? _onboardingCompleteFuture;

  @override
  void initState() {
    super.initState();
    _onboardingCompleteFuture = checkIfOnboardingIsComplete();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDark
            ? AppColors.systemBarDark(context)
            : AppColors.systemBarLight(context),
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDark
            ? AppColors.systemBarDark(context)
            : AppColors.systemBarLight(context),
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
    );

    return RestartWidget(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(position: offsetAnimation, child: child);
        },
        child: ShadApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          key: ValueKey(themeProvider.themeMode),
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: ShadThemeData(
            colorScheme: ShadZincColorScheme.light(
              primary: AppColors.appPrimary,
              primaryForeground: AppColors.white(context),
            ),
            brightness: Brightness.light,
            textTheme: ShadTextTheme(family: 'Raleway'),
          ),
          darkTheme: ShadThemeData(
            colorScheme: ShadZincColorScheme.dark(
              primary: AppColors.appPrimary,
              primaryForeground: AppColors.white(context),
            ),
            brightness: Brightness.dark,
            textTheme: ShadTextTheme(family: 'Raleway'),
          ),
          home: FutureBuilder<bool>(
            future: _onboardingCompleteFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (snapshot.data == true) {
                // Onboarding complete - show dashboard
                return const DashboardScreen();
              } else {
                // Show onboarding
                return DashboardScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
