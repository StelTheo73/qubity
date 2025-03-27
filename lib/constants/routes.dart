enum AppRoute {
  about('/about'),
  game('/game'),
  home('/'),
  levels('/levels'),
  onboarding('/onboarding'),
  quiz('/quiz'),
  quizHistory('/quiz-history'),
  quizMenu('/quiz-menu'),
  quizResult('/quiz-result'),
  spaceships('/spaceships'),
  settings('/settings'),
  tutorial('/tutorial');

  const AppRoute(this.route);

  final String route;
}
