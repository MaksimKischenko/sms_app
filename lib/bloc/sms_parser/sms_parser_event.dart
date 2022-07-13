part of 'sms_parser_bloc.dart';

abstract class SmsParserEvent extends Equatable {
  const SmsParserEvent();

  @override
  List<Object?> get props => [];
}

class SmsParserRun extends SmsParserEvent {
  
  final List<SmsMessage>? messages;

  const SmsParserRun({
    required this.messages,
  });

  @override
  List<Object?> get props => [messages];
}
