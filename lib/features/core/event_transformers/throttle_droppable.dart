import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

/// Default throttle duration for droppable.
const throttleDuration = Duration(milliseconds: 100);

/// Droppable Event Transformer.
/// It drops any upcoming events if there's already an active event.
EventTransformer<E> throttleDroppable<E>([
  Duration duration = throttleDuration,
]) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}
