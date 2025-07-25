import 'package:darto_types/darto_types.dart';

final _requestCounts = <String, List<DateTime>>{};

Middleware rateLimiterFn(
    {int maxRequests = 100, Duration duration = const Duration(minutes: 1)}) {
  return (req, res, next) {
    final ip = req.ip;
    final now = DateTime.now();
    final requests = _requestCounts.putIfAbsent(ip, () => []);
    requests.removeWhere((t) => now.difference(t) > duration);
    if (requests.length >= maxRequests) {
      res.status(429).json({'error': 'Too many requests'});
      return;
    }
    requests.add(now);
    next();
  };
}
