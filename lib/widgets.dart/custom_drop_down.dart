
import 'package:flutter/material.dart';

import 'package:sms_app/styles.dart';

class CustomDropDown<T> extends StatelessWidget {


  final String name;
  final Set<T> items;
  final String Function(T item) itemBuilder;
  final Function(T?) onChanged;

  const CustomDropDown({
    Key? key,
    required this.name,
    required this.items,
    required this.itemBuilder,
    required this.onChanged,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      items: items.map((item) => DropdownMenuItem<T>(
        value: item,
        child: Text(itemBuilder(item))
      )).toList(),
      onChanged: onChanged,
      isExpanded: true,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        isDense: true,
        labelText: name,
        labelStyle: const TextStyle(
          color: AppStyles.mainTextColor
        ),
        // helperText: hintText,
        hintStyle: const TextStyle(
          color: AppStyles.mainTextColor
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: AppStyles.mainColor.withOpacity(0.4), width: 2),
          borderRadius: BorderRadius.circular(5)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: AppStyles.mainColor.withOpacity(0.4), width: 2),
          borderRadius: BorderRadius.circular(5)
        )
      ),              
    );
  }
}
