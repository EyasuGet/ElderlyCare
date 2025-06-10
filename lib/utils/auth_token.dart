import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _userTokenKey = 'user_token';
  static const String _roleKey = 'role';

  // Save auth token
  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userTokenKey, token);
  }

  // Fetch auth token
  Future<String?> fetchAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTokenKey);
  }

  // Save user role
  Future<void> saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
  }

  // Fetch user role
  Future<String?> fetchRole() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString(_roleKey);
    return (role == 'nurse' || role == 'user') ? role : null;
  }

  // Clear session
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Get user info from JWT token (decode payload)
  Future<Map<String, dynamic>?> getUserInfoFromToken() async {
    final token = await fetchAuthToken();
    if (token == null) return null;
    final parts = token.split('.');
    if (parts.length != 3) return null;
    final payload = parts[1];
    String normalized = base64Url.normalize(payload);
    final payloadMap = json.decode(utf8.decode(base64Url.decode(normalized)));
    if (payloadMap is Map<String, dynamic>) {
      return payloadMap;
    }
    return null;
  }
}