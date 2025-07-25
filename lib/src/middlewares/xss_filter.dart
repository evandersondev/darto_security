import 'package:darto_types/darto_types.dart';

Middleware xssFilterFn() {
  return (req, res, next) {
    res.set('X-XSS-Protection', '1; mode=block');
    next();
  };
}
