import 'dart:math';
import 'package:darto/darto.dart';

String _generateNonce([int length = 16]) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final rand = Random.secure();
  return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
}

Middleware nonceCSP() {
  return (req, res, next) {
    final nonce = _generateNonce();
    req.context['nonce'] = nonce;
    res.set('Content-Security-Policy', "script-src 'nonce-\$nonce'");
    next();
  };
}