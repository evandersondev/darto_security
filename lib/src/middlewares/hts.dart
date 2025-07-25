import 'package:darto_types/darto_types.dart';

Middleware hsts(
    {int maxAge = 15552000,
    bool includeSubDomains = true,
    bool preload = false}) {
  return (req, res, next) {
    var value = 'max-age=$maxAge';
    if (includeSubDomains) value += '; includeSubDomains';
    if (preload) value += '; preload';

    res.set('Strict-Transport-Security', value);
    next();
  };
}
