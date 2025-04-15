import 'package:darto/darto.dart';

Middleware securityHeadersFn() {
  return (req, res, next) {
    res.set('X-Content-Type-Options', 'nosniff');
    res.set('X-Frame-Options', 'DENY');
    res.set('X-XSS-Protection', '1; mode=block');
    res.set('Referrer-Policy', 'no-referrer');
    next();
  };
}
