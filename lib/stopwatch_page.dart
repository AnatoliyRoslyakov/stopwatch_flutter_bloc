import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/stopwatch_bloc.dart';
import 'bloc/stopwatch_event.dart';
import 'bloc/stopwatch_state.dart';

class StopwatchPage extends StatelessWidget {
  const StopwatchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int time = context.select((StopwatchBloc bloc) => bloc.state.time);
    final seconds = (time % 60).toString().padLeft(2, '0');
    final minutes = ((time / 60).floor() % 60).toString().padLeft(2, '0');
    final hours = (time / 3600).floor().toString().padLeft(2, '0');
    return Scaffold(
      body: Center(child:
          BlocBuilder<StopwatchBloc, StopwatchState>(builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state is StopwatchInitial) ...[
              IconButton(
                  onPressed: () =>
                      context.read<StopwatchBloc>().add(StopwatchStarted(
                            time: state.time,
                          )),
                  icon: const Icon(Icons.play_arrow)),
            ],
            if (state is StopwatchRunInProgress) ...[
              IconButton(
                onPressed: () =>
                    context.read<StopwatchBloc>().add(StopwatchPaused()),
                icon: const Icon(Icons.pause),
              )
            ],
            if (state is StopwatchRunPause) ...[
              IconButton(
                onPressed: () =>
                    context.read<StopwatchBloc>().add(StopwatchResumed()),
                icon: const Icon(Icons.play_arrow),
              ),
            ],
            Text('$hours:$minutes:$seconds'),
            IconButton(
              onPressed: () =>
                  context.read<StopwatchBloc>().add(StopwatchReset()),
              icon: const Icon(Icons.restore),
            ),
          ],
        );
      })),
    );
  }
}
