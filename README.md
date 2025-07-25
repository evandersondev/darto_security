<p align="center">
  <p align="center">
  <a href="https://github.com/evandersondev/darto_security"><h1 align="center">Darto Security</h1></a>
  <br/>
    The <code>darto_security</code> package provides a set of plug-and-play middlewares inspired by <a href="https://helmetjs.github.io/">Helmet.js</a> to improve the security of your Darto application. These middlewares help protect your API against common threats like XSS, CSRF, request spamming, and more.
  </p>
</p>

<br/>

### Support 💖

If you find Darto Security useful, please consider supporting its development 🌟[Buy Me a Coffee](https://buymeacoffee.com/evandersondev).🌟 Your support helps us improve the package and make it even better!

<br>
<br>

## Installing

```bash
dart pub add darto_security
```

or

Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  darto_security: ^0.0.2
```

Then, run the following command:

```bash
flutter pub get
```

---

<br>

## Usage

To use all security features with default settings:

```dart
import 'package:darto/darto.dart';
import 'package:darto_security/darto_security.dart';

void main() {
  final app = Darto();

  app.use(dartoSecurity());

  app.get('/', (req, res) {
    res.send('🔐 Secured by darto_security!');
  });

  app.listen(3000, () {
    print('🔹 Server is running at http://localhost:3000');
  });
}
```

<br>

---

<br>

## Available Middleware Flags

You can selectively enable or disable each middleware by passing its respective flag:

| Middleware              | Flag name               | Default | Description                                          |
| ----------------------- | ----------------------- | ------- | ---------------------------------------------------- |
| Block User Agents       | `blockUserAgents`       | `true`  | Blocks user agents provided in `blockedAgents`.      |
| Block IPs               | `ipBlock`               | `true`  | Blocks IPs provided in `blockedIps`.                 |
| CORS                    | `corsEnabled`           | `true`  | Enables CORS.                                        |
| Content-Security-Policy | `contentSecurityPolicy` | `true`  | Adds `Content-Security-Policy` header.               |
| Nonce CSP               | `nonceCsp`              | `false` | Adds nonce-based CSP header.                         |
| Frameguard              | `frameGuard`            | `true`  | Protects against clickjacking via `X-Frame-Options`. |
| Hide Powered By         | `hidePoweredBy`         | `true`  | Removes `X-Powered-By` header.                       |
| HSTS                    | `hstsEnabled`           | `true`  | Adds `Strict-Transport-Security` header.             |
| IE No Open              | `ieNoOpenEnabled`       | `true`  | Adds `X-Download-Options` for IE.                    |
| No Cache                | `noCacheEnabled`        | `true`  | Prevents caching of sensitive data.                  |
| No Sniff                | `noSniff`               | `true`  | Adds `X-Content-Type-Options: nosniff`.              |
| Rate Limiting           | `rateLimit`             | `true`  | Prevents abuse via excessive requests.               |
| Referrer Policy         | `referrerPolicy`        | `true`  | Adds `Referrer-Policy` header.                       |
| Generic Sec Headers     | `securityHeaders`       | `true`  | Adds common security headers.                        |
| XSS Protection          | `xssProtection`         | `true`  | Enables XSS filter in browsers.                      |

<br>

---

<br>

## Custom Parameters

Some middlewares accept custom parameters:

```dart
dartoSecurity(
  blockedAgents: ['BadBot', 'Scanner'],
  blockedIps: ['192.168.0.10'],
  allowedOrigins: ['https://myapp.com'],
  allowedMethods: ['GET', 'POST'],
  rateLimitMaxRequests: 50,
  rateLimitDuration: Duration(seconds: 30),
);
```

<br>

### Parameters Description

| Parameter              | Type           | Description                    |
| ---------------------- | -------------- | ------------------------------ |
| `blockedAgents`        | `List<String>` | User agents to block.          |
| `blockedIps`           | `List<String>` | IP addresses to block.         |
| `allowedOrigins`       | `List<String>` | Origins allowed in CORS.       |
| `allowedMethods`       | `List<String>` | Methods allowed in CORS.       |
| `rateLimitMaxRequests` | `int`          | Max requests before blocking.  |
| `rateLimitDuration`    | `Duration`     | Time window for rate limiting. |

> ⚠️ Middlewares like `blockUserAgents` and `ipBlock` require their respective lists to be non-empty to take effect.

<br>

---

<br>

## Disable Middleware

To disable a specific middleware, set its flag to `false`:

```dart
dartoSecurity(
  xssProtection: false,
  rateLimit: false,
  corsEnabled: false,
);
```

<br>

---

<br>

## Full Example

```dart
import 'package:darto/darto.dart';
import 'package:darto_security/darto_security.dart';

void main() {
  final app = Darto();

  app.use(dartoSecurity(
    blockedAgents: ['BadBot'],
    blockedIps: ['123.123.123.123'],
    allowedOrigins: ['https://secure-app.com'],
    allowedMethods: ['GET', 'POST'],
    rateLimitMaxRequests: 60,
    rateLimitDuration: Duration(minutes: 1),
  ));

  app.get('/', (req, res) {
    res.send('🔐 Secured and customized!');
  });

  app.listen(3000, () {
    print('🔹 Server is running at http://localhost:3000');
  });
}
```

<br>

---

<br>

Made by evandersondev with ❤️ for Dart/Flutter developers! 🎯
