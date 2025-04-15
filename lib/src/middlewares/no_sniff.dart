import 'package:darto/darto.dart';

Middleware noSniffFn() {
  return (req, res, next) {
    res.set('X-Content-Type-Options', 'nosniff');
    next();
  };
}
