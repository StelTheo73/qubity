enum AppRoute {
  about('/about'),
  game('/game'),
  home('/'),
  levels('/levels'),
  quiz('/quiz'),
  quizHistory('/quiz-history'),
  quizMenu('/quiz-menu'),
  quizResult('/quiz-result'),
  spaceships('/spaceships'),
  settings('/settings');

  const AppRoute(this.route);

  final String route;
}
