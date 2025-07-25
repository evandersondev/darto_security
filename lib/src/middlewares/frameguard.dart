import 'package:darto_types/darto_types.dart';

Middleware frameguard({String action = 'SAMEORIGIN'}) {
  return (req, res, next) {
    res.set('X-Frame-Options', action);
    next();
  };
}
