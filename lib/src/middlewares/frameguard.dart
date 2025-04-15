import 'package:darto/darto.dart';

Middleware frameguard({String action = 'SAMEORIGIN'}) {
  return (req, res, next) {
    res.set('X-Frame-Options', action);
    next();
  };
}
