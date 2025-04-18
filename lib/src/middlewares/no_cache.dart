import 'package:darto/darto.dart';

Middleware noCache() {
  return (req, res, next) {
    res.set('Cache-Control',
        'no-store, no-cache, must-revalidate, proxy-revalidate');
    res.set('Pragma', 'no-cache');
    res.set('Expires', '0');
    next();
  };
}
