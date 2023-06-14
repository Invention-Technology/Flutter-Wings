import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helpers/date.helper.dart';
import 'text.input.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class TimeInput extends StatelessWidget {
  TextEditingController? controller;
  final FocusNode? nextNode;
  final String title;
  TimeOfDay? _selectedDate;
  final Function()? onTap;

  bool disable = false;

  TimeInput(
      {Key? key, this.controller, this.nextNode, this.title = "", this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputText(
      title: title,
      isOptional: true,
      onTab: () async {
        TimeOfDay? newSelectedDate = await showTimePicker(
          context: context,
          initialTime: _selectedDate != null ? _selectedDate! : TimeOfDay.now(),
        );

        if (newSelectedDate != null) {
          _selectedDate = newSelectedDate;

          controller!.value = TextEditingValue(
              text: DateFormat("HH:mm").format(fromTime(_selectedDate!)));

          if (onTap != null) {
            onTap!();
          }
          // controller!
          //   ..text = _selectedDate!.year.toString() +
          //       "-" +
          //       _selectedDate!.month.toString() +
          //       "-" +
          //       _selectedDate!.day.toString()
          //   ..selection = TextSelection.fromPosition(TextPosition(
          //       offset: controller!.text.length,
          //       affinity: TextAffinity.upstream));
        }
      },
      keyboardType: TextInputType.datetime,
      controller: controller,
      focusNode: AlwaysDisabledFocusNode(),
      nextNode: nextNode,
      suffix: const Icon(CupertinoIcons.calendar_badge_plus),
    );
  }
}
