abstract class StopwatchState {
  final int time;

  StopwatchState({required this.time});
}

class StopwatchInitial extends StopwatchState {
  StopwatchInitial(int time) : super(time: time);
}

class StopwatchRunInProgress extends StopwatchState {
  StopwatchRunInProgress(int time) : super(time: time);
}

class StopwatchRunPause extends StopwatchState {
  StopwatchRunPause(int time) : super(time: time);
}
