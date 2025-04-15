import 'package:darto/darto.dart';
import 'package:darto_security/src/middlewares/hide_powered_by.dart';
import 'package:darto_security/src/middlewares/no_sniff.dart';
import 'package:darto_security/src/middlewares/rate_limiter.dart';
import 'package:darto_security/src/middlewares/security_headers.dart';
import 'package:darto_security/src/middlewares/user_agent_blocker.dart';
import 'package:darto_security/src/middlewares/xss_filter.dart';

import 'middlewares/cors.dart';
import 'middlewares/csp.dart';
import 'middlewares/frameguard.dart';
import 'middlewares/hts.dart';
import 'middlewares/ie_no_open.dart';
import 'middlewares/ip_blocker.dart';
import 'middlewares/no_cache.dart';
import 'middlewares/nonce_csp.dart';

Middleware dartoSecurity({
  bool blockUserAgents = true,
  bool ipBlock = true,
  bool corsEnabled = true,
  bool contentSecurityPolicy = true,
  bool frameGuard = true,
  bool hidePoweredBy = true,
  bool hstsEnabled = true,
  bool ieNoOpenEnabled = true,
  bool noCacheEnabled = true,
  bool noSniff = true,
  bool rateLimit = true,
  bool referrerPolicy = true,
  bool securityHeaders = true,
  bool xssProtection = true,
  bool nonceCsp = false,
  // options for middlewares when needs
  List<String> blockedIps = const [],
  List<String> blockedAgents = const [],
  List<String> allowedOrigins = const ['*'],
  List<String> allowedMethods = const ['GET', 'POST', 'PUT', 'DELETE'],
  int rateLimitMaxRequests = 100,
  Duration rateLimitDuration = const Duration(minutes: 1),
}) {
  final middlewares = <Middleware>[];

  if (blockUserAgents && blockedAgents.isNotEmpty) {
    middlewares.add(blockUserAgentsFn(blockedAgents));
  }

  if (ipBlock && blockedIps.isNotEmpty) {
    middlewares.add(ipBlocker(blockedIps));
  }

  if (corsEnabled) {
    middlewares.add(cors(
      allowedOrigins: allowedOrigins,
      allowedMethods: allowedMethods,
    ));
  }

  if (contentSecurityPolicy) {
    middlewares.add(csp(policy: "default-src 'self'"));
  }

  if (nonceCsp) {
    middlewares.add(nonceCSP());
  }

  if (frameGuard) {
    middlewares.add(frameguard());
  }

  if (hidePoweredBy) {
    middlewares.add(hidePoweredByFn());
  }

  if (hstsEnabled) {
    middlewares.add(hsts());
  }

  if (ieNoOpenEnabled) {
    middlewares.add(ieNoOpen());
  }

  if (noCacheEnabled) {
    middlewares.add(noCache());
  }

  if (noSniff) {
    middlewares.add(noSniffFn());
  }

  if (rateLimit) {
    middlewares.add(rateLimiterFn(
      maxRequests: rateLimitMaxRequests,
      duration: rateLimitDuration,
    ));
  }

  if (referrerPolicy) {
    middlewares.add((req, res, next) {
      res.set('Referrer-Policy', 'no-referrer');
      next();
    });
  }

  if (securityHeaders) {
    middlewares.add(securityHeadersFn());
  }

  if (xssProtection) {
    middlewares.add(xssFilterFn());
  }

  return _combineMiddlewares(middlewares);
}

Middleware _combineMiddlewares(List<Middleware> middlewares) {
  return (req, res, next) {
    int index = 0;
    void nextMiddleware() {
      if (index < middlewares.length) {
        final middleware = middlewares[index++];
        middleware(req, res, nextMiddleware);
      } else {
        next();
      }
    }

    nextMiddleware();
  };
}
