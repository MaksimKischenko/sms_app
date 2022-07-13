part of 'sms_parser_bloc.dart';

abstract class SmsParserState extends Equatable {
  const SmsParserState();
  
  @override
  List<Object?> get props => [];
}

class SmsParserLoading extends SmsParserState {}

class SmsParserSuccess extends SmsParserState {

  final double paySum;

  const SmsParserSuccess({
    required this.paySum,
  });

  @override
  List<Object?> get props => [paySum];
}
