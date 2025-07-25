import 'package:darto/darto.dart';
import 'package:darto_security/darto_security.dart';

void main() {
  final app = Darto();

  app.use(dartoSecurity(
    blockedAgents: ['BadBot'],
    blockedIps: ['123.123.123.123'],
    allowedOrigins: ['https://secure-app.com'],
    allowedMethods: ['POST'],
    rateLimitMaxRequests: 10,
    rateLimitDuration: Duration(minutes: 1),
  ));

  app.get('/', (req, res) {
    res.send('🔐 Secured and customized!');
  });

  app.listen(3333, () {
    print('🔹 Server is running at http://localhost:3000');
  });
}
