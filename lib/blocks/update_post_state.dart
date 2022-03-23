
import 'package:equatable/equatable.dart';

abstract class UpdatePostState extends Equatable{

  @override
  List<Object> get props => [];

}

class UpdatePostInit extends UpdatePostState{}

class UpdatePostLoading extends UpdatePostState{}

class UpdatePostLoaded extends UpdatePostState{
  late final bool isUpdated;

  UpdatePostLoaded({required this.isUpdated});
}

class UpdatePostError extends UpdatePostState{
  late final error;

  UpdatePostError({this.error});
}