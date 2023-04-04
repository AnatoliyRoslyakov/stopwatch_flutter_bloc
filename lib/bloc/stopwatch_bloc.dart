import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ticker.dart';
import 'stopwatch_event.dart';
import 'stopwatch_state.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  final Ticker1 _ticker;
  static const int _initialTime = 0;
  StreamSubscription<int>? _stopwatchSubscription;

  StopwatchBloc({required Ticker1 ticker})
      : _ticker = ticker,
        super(StopwatchInitial(_initialTime)) {
    on<StopwatchStarted>(_onStarted);
    on<StopwatchPaused>(_onPaused);
    on<StopwatchResumed>(_onResumed);
    on<StopwatchReset>(_onReset);
    on<StopwatchTicked>(_onTicked);
  }

  @override
  Future<void> close() {
    _stopwatchSubscription?.cancel();
    return super.close();
  }

  void _onStarted(StopwatchStarted event, Emitter<StopwatchState> emit) {
    emit(StopwatchRunInProgress(event.time));
    _stopwatchSubscription?.cancel();
    _stopwatchSubscription = _ticker
        .tick(time: event.time)
        .listen((time) => add(StopwatchTicked(time: time)));
  }

  void _onPaused(StopwatchPaused event, Emitter<StopwatchState> emit) {
    if (state is StopwatchRunInProgress) {
      _stopwatchSubscription?.pause();
      emit(StopwatchRunPause(state.time));
    }
  }

  void _onResumed(StopwatchResumed event, Emitter<StopwatchState> emit) {
    if (state is StopwatchRunPause) {
      _stopwatchSubscription?.resume();
      emit(StopwatchRunInProgress(state.time));
    }
  }

  void _onReset(StopwatchReset event, Emitter<StopwatchState> emit) {
    if (state is StopwatchRunInProgress || state is StopwatchRunPause) {
      _stopwatchSubscription?.cancel();
      emit(StopwatchInitial(_initialTime));
    }
  }

  void _onTicked(StopwatchTicked event, Emitter<StopwatchState> emit) {
    emit(StopwatchRunInProgress(event.time));
  }
}
