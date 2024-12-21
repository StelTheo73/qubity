enum AppRoute {
  about('/about'),
  game('/game'),
  home('/'),
  levels('/levels'),
  quiz('/quiz'),
  spaceships('/spaceships'),
  settings('/settings');

  const AppRoute(this.route);

  final String route;
}
