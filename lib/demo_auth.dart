// Classroom demo authentication. One registered account is stored in memory.
// A new registration replaces the previous one. Restarting the app removes it.
// The default admin account (admin / admin123) always works. No database.
class DemoAuth {
  static String? registeredUsername;
  static String? registeredPassword;

  static bool login(String username, String password) {
    final isAdmin = username == 'admin' && password == 'admin123';
    final isRegistered = registeredUsername != null &&
        username == registeredUsername &&
        password == registeredPassword;
    return isAdmin || isRegistered;
  }

  static void register(String username, String password) {
    registeredUsername = username;
    registeredPassword = password;
  }
}
