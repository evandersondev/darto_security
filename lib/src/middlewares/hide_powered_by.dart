import 'package:darto_types/darto_types.dart';

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
