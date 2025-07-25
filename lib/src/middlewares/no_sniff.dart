import 'package:darto_types/darto_types.dart';

Middleware noSniffFn() {
  return (req, res, next) {
    res.set('X-Content-Type-Options', 'nosniff');
    next();
  };
}
