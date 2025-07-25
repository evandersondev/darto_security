import 'package:darto_types/darto_types.dart';

Middleware noCache() {
  return (req, res, next) {
    res.set('Cache-Control',
        'no-store, no-cache, must-revalidate, proxy-revalidate');
    res.set('Pragma', 'no-cache');
    res.set('Expires', '0');
    next();
  };
}
