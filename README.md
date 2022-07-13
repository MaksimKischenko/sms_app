## Guidelines
Run the example of connecting to OpenFin and creating applications

1. Clone this repository

2. If pubspec.yaml file drops error with pockets compatibility try write a command: dart pub upgrade --null-safety 

3. Go to release directory and start void main (run)

4. Once the flutter app starts in emulator you will see screens of app

5. In App you can work with sms in next way:
    #### read all sms notifications from you mobile
    #### chose sms notifications by header
    #### see info of the all sum of money that was payed from BNB card in period of time


## Source Code Review

Source code for the example is located in /lib/. 
Start point of app is main.dart

We use Bloc core as main statemanagment instrument in all app

1. Lets begin with AndroidManifest.xml review and special intent-filter and permissions for this app

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.sms_app">

   <uses-permission android:name="android.permission.RECEIVE_SMS"/>
   <uses-permission android:name="android.permission.READ_SMS"/>
   <application
        android:label="sms_app"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
		<receiver android:name="com.shounakmulay.telephony.sms.IncomingSmsReceiver"
		    android:permission="android.permission.BROADCAST_SMS" android:exported="true">
		    <intent-filter>
			<action android:name="android.provider.Telephony.SMS_RECEIVED"/>
		    </intent-filter>
		</receiver>
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
</manifest>

```

2. SMSGeneratorBloc needs to load sms as a Future<List<SmsMessage>>

```dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telephony/telephony.dart';

part 'sms_generator_event.dart';
part 'sms_generator_state.dart';

class SmsGeneratorBloc extends Bloc<SmsGeneratorEvent, SmsGeneratorState> {

  SmsGeneratorBloc() 
  : super(SmsGeneratorLoading()) {
    on<SmsGeneratorEvent>(_onEvent); 
  }

  void _onEvent(
    SmsGeneratorEvent event,
    Emitter<SmsGeneratorState> emit
  ) {
    if( event is SmsGeneratorInitial) return _onSmsGeneratorInitial(event, emit);
    if (event is SmsGeneratorRun) return _onSmsGeneratorRun(event, emit);

  }

  void _onSmsGeneratorInitial(
    SmsGeneratorInitial event,
    Emitter<SmsGeneratorState> emit
  ) async {

    emit(SmsGeneratorLoading());

    try {
      
     final Telephony telephony = Telephony.instance;

     final messages = await telephony.getInboxSms(
      columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
      sortOrder: [OrderBy(SmsColumn.ADDRESS, sort: Sort.ASC),
        OrderBy(SmsColumn.BODY)]
     );

     emit(SmsGeneratorSuccess(
        messages: messages
     ));

    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(SmsGeneratorError(
        error: error
      ));
    }
  }


  void _onSmsGeneratorRun(
    SmsGeneratorRun event,
    Emitter<SmsGeneratorState> emit
  ) async {

    emit(SmsGeneratorLoading());

    try {
      
     final Telephony telephony = Telephony.instance;

     final messages = await telephony.getInboxSms(
      columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
      filter: SmsFilter.where(SmsColumn.ADDRESS).equals(event.bankName),
      sortOrder: [OrderBy(SmsColumn.ADDRESS, sort: Sort.ASC),
        OrderBy(SmsColumn.BODY)]
     );


     emit(SmsGeneratorSuccess(
        messages: messages
     ));

    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(SmsGeneratorError(
        error: error
      ));
    }
  }
}
```

3. SmsParserBloc needs to parse info from sms text in a nessesary way 

```dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telephony/telephony.dart';

part 'sms_parser_event.dart';
part 'sms_parser_state.dart';

class SmsParserBloc extends Bloc<SmsParserEvent, SmsParserState> {

  SmsParserBloc() 
  : super(SmsParserLoading()) {
    on<SmsParserEvent>(_onEvent); 
  }

  void _onEvent(
    SmsParserEvent event,
    Emitter<SmsParserState> emit
  ) {
    if (event is SmsParserRun) return _onSmsParserRun(event, emit);
  }

  void _onSmsParserRun(
    SmsParserRun event,
    Emitter<SmsParserState> emit
  ) async {

    emit(SmsParserLoading());

    var listMessages = event.messages;
    String payInfo = '';  
    List<double?> finalListSum = [];
    double finalSum = 0.0; 


    listMessages?.forEach(((element) {
      if((element.body ?? '' ).contains('Card#9845')) {
        var list = element.body?.split(';');

        list?.forEach((item) {
          if(item.contains('Oplata')) {
            payInfo = item;
          }
        });   

        payInfo.split(' ').forEach((item) {
          if(double.tryParse(item) != null) {
            var paySum = double.tryParse(item);
            finalListSum.add(paySum);
          }
        });
      }
    }));

    finalListSum.forEach((element) {
      finalSum = finalSum + element!;
    });
  
    emit(SmsParserSuccess(
        paySum: finalSum     
     ));
  }
}
```

## More Info
More information and documentation can be found at:

#### https://pub.dev/packages/flutter_bloc
#### https://pub.dev/packages/telephony








