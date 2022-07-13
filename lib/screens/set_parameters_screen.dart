import 'dart:io';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sms_app/config.dart';
import 'package:sms_app/screens/info_screen.dart';
import 'package:sms_app/screens/widgets/widgets.dart';
import 'package:sms_app/styles.dart';
import 'package:sms_app/widgets.dart/action_button.dart';
import 'package:sms_app/widgets.dart/custom_drop_down.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sms_generator/sms_generator_bloc.dart';


class SetParametersScreen extends StatefulWidget {

  const SetParametersScreen({ Key? key }) : super(key: key);

  @override
  State<SetParametersScreen> createState() => _SetParametersScreenState();
}

class _SetParametersScreenState extends State<SetParametersScreen> {

  String? selectedBank;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          name: AppConfig.commonAppBarName, 
          iconButton: IconButton(
            onPressed: () => exit(0), 
            icon:const Icon(Icons.logout), 
          )
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Scrollbar(
              child: ResponsiveBuilder(
                builder: (context, sizingInformation) {

                  late double width;
                  late double height;

                  if (sizingInformation.isMobile || sizingInformation.isTablet) {
                    width = sizingInformation.screenSize.width;
                    height = sizingInformation.screenSize.height;
                  }            
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        BlocBuilder<SmsGeneratorBloc, SmsGeneratorState>(
                          builder: (context, state) {
                            Widget body = Container();
                            if(state is SmsGeneratorSuccess) {
                              body = CustomDropDown<String?>(
                                items: state.messages!.map((e) => e.address).toSet(),
                                itemBuilder: (item) => item ?? '',
                                name: 'SMS-VIEWER', 
                                onChanged: (value) {
                                  selectedBank = value;
                                }
                              );
                            }
                            return body;
                          }
                        ),                      
                        const SizedBox(height: 20),
                        ActionButton(
                          name: 'Далее', 
                          buttonGradientColors: AppStyles.gradientColor, 
                          onTap: () {
                            context.read<SmsGeneratorBloc>().add(SmsGeneratorRun(
                                bankName: selectedBank ?? '', 
                              )
                            );
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoScreen()));
                          }, 
                          sizingInformation: sizingInformation
                        )
                      ],
                    ),
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }


}