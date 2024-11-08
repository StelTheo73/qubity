enum AppRoute {
  about('/about'),
  game('/game'),
  home('/'),
  levels('/levels'),
  settings('/settings');

  const AppRoute(this.route);

  final String route;
}
