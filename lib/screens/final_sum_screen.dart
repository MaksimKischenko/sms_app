import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sms_app/bloc/sms_parser/sms_parser_bloc.dart';
import 'package:sms_app/screens/widgets/common_appbar.dart';
import 'package:sms_app/styles.dart';

class FinalSumScreen extends StatelessWidget {
  const FinalSumScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        name: 'Final Sum', 
        iconButton: IconButton(
          onPressed: () {}, 
          icon: const Icon(Icons.money)
        )
      ),
      body: BlocBuilder<SmsParserBloc, SmsParserState>(
        builder: ((context, state) {
           Widget body = Container();
           if(state is SmsParserLoading) {
            body = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(width: double.maxFinite),
                  CircularProgressIndicator(
                    color: AppStyles.secondaryColor,
                  )
                ],
              );               
           } else if(state is SmsParserSuccess) {
             body = Scrollbar(
               child: ResponsiveBuilder(
                 builder: (context, sizingInformation) {
                  late double width;
                  late double height;

                  if (sizingInformation.isMobile || sizingInformation.isTablet) {
                    width = sizingInformation.screenSize.width;
                    height = sizingInformation.screenSize.height;
                  }       
                   return Center(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: height / 2,
                              minWidth: width / 2
                            ),
                            child: const FlutterLogo(),
                         ),                   
                         DefaultTextStyle(
                            style: AppStyles.sumStyle, 
                            textAlign: TextAlign.center,
                            child: AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                WavyAnimatedText(state.paySum.toString().toUpperCase())
                              ],
                            ),
                          ),
                       ],
                     ),
                   );
                 }
               ),
             );
           }
           return body;
        })
      ),
    );
  }
}