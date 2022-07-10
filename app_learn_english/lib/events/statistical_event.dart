
import 'package:equatable/equatable.dart';

abstract class StatisticalEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StatisticalFetchedEvent extends StatisticalEvent {

}
class StatisticalFetchedAgoEvent extends StatisticalEvent {
  int weekAgo;
  StatisticalFetchedAgoEvent(this.weekAgo);
}