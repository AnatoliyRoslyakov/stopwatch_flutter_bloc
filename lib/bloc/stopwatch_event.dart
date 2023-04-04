abstract class StopwatchEvent {
  const StopwatchEvent();
}

class StopwatchStarted extends StopwatchEvent {
  final int time;

  const StopwatchStarted({required this.time});
}

class StopwatchPaused extends StopwatchEvent {}

class StopwatchResumed extends StopwatchEvent {}

class StopwatchReset extends StopwatchEvent {}

class StopwatchTicked extends StopwatchEvent {
  final int time;
  const StopwatchTicked({required this.time});
}
