import 'package:darto/darto.dart';

Middleware ieNoOpen() {
  return (req, res, next) {
    res.set('X-Download-Options', 'noopen');
    next();
  };
}
