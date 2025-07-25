import 'package:darto_types/darto_types.dart';

Middleware ipBlocker(List<String> blockedIps) {
  return (req, res, next) {
    final ip = req.ip;
    if (blockedIps.contains(ip)) {
      res.status(403).json({'error': 'Access denied'});
      return;
    }
    next();
  };
}
