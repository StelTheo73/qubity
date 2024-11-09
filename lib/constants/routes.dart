enum AppRoute {
  about('/about'),
  game('/game'),
  home('/'),
  levels('/levels'),
  spaceships('/spaceships'),
  settings('/settings');

  const AppRoute(this.route);

  final String route;
}
