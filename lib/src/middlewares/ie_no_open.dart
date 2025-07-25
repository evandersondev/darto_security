import 'package:darto_types/darto_types.dart';

Middleware ieNoOpen() {
  return (req, res, next) {
    res.set('X-Download-Options', 'noopen');
    next();
  };
}
