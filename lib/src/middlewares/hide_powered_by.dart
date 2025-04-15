import 'package:darto/darto.dart';

Middleware hidePoweredByFn([String? customValue]) {
  return (req, res, next) {
    if (customValue != null) {
      res.set('X-Powered-By', customValue);
    } else {
      res.removeHeader('X-Powered-By');
    }
    next();
  };
}
