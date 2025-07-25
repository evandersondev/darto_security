import 'package:darto_types/darto_types.dart';

Middleware blockUserAgentsFn(List<String> blockedAgents) {
  return (req, res, next) {
    final userAgent = req.headers.get('user-agent') ?? '';
    if (blockedAgents.any(
        (agent) => userAgent.toLowerCase().contains(agent.toLowerCase()))) {
      res.status(403).json({'error': 'User-Agent not allowed'});
      return;
    }
    next();
  };
}
