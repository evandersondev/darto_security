import 'package:darto_types/darto_types.dart';

Middleware cors({
  List<String> allowedOrigins = const ['*'],
  List<String> allowedMethods = const ['GET', 'POST', 'PUT', 'DELETE'],
}) {
  return (req, res, next) {
    final origin = req.headers.get('origin') ?? '*';
    if (allowedOrigins.contains('*') || allowedOrigins.contains(origin)) {
      res.set('Access-Control-Allow-Origin', origin);
      res.set('Access-Control-Allow-Methods', allowedMethods.join(', '));
      res.set('Access-Control-Allow-Headers', 'Content-Type');
    }
    if (req.method == 'OPTIONS') {
      res.status(204).end();
      return;
    }
    next();
  };
}
