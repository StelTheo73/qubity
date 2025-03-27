enum Sounds {
  Achievement('achievement.wav'),
  Completion('completion.wav'),
  Explosion('explosion.wav'),
  Shot('shot.wav');

  const Sounds(this.sound);

  final String sound;
}
