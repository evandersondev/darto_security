import 'package:darto_types/darto_types.dart';

Middleware csp({required String policy}) {
  return (req, res, next) {
    res.set('Content-Security-Policy', policy);
    next();
  };
}
