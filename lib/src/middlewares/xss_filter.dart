import 'package:darto/darto.dart';

Middleware xssFilterFn() {
  return (req, res, next) {
    res.set('X-XSS-Protection', '1; mode=block');
    next();
  };
}
