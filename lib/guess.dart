enum Guess { skip, incorrect, sameArtist, correct }

class GuessInfo {
  static String summarize(List<Guess> guesses) {
    var emojis = guesses.map((guess) {
      switch (guess) {
        case Guess.skip:
          return '⬛';
        case Guess.incorrect:
          return '🟥';
        case Guess.sameArtist:
          return '🟨';
        case Guess.correct:
          return '🟩';
      }
    }).toList();
    while (emojis.length < 5) {
      emojis.add('⬜');
    }
    return "${'${guesses.length}/5'} [${emojis.join('')}]";
  }
}
