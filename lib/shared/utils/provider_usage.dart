// // To access theme mode in any widget:
// final themeProvider = Provider.of<ThemeProvider>(context);
// ThemeMode currentTheme = themeProvider.themeMode;

// // To change the theme:
// Provider.of<ThemeProvider>(context, listen: false).setTheme(AppThemeMode.dark);

// // To access connectivity:
// final connectivity = Provider.of<ConnectivityProvider>(context).connectionStatus;

// // To check or change modal visibility:
// final isModalVisible = Provider.of<ModalVisibleProvider>(context).isVisible;
// Provider.of<ModalVisibleProvider>(context, listen: false).setVisibility(true);
