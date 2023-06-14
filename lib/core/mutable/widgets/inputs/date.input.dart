import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:wings/core/mutable/helpers/date_picker.helper.dart';

import 'text.input.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class DateInput extends StatelessWidget {
  TextEditingController? controller;
  final FocusNode? nextNode;
  final String title;
  DateTime? _selectedDate;
  final Function()? onTap;
  Color? shadowColor;
  DateTime? firstDate;
  DateTime? lastDate;

  bool disable = false;

  DateInput({
    Key? key,
    this.controller,
    this.nextNode,
    this.title = "",
    this.shadowColor,
    this.firstDate,
    this.lastDate,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputText(
      title: title,
      isOptional: true,
      shadowColor: shadowColor,
      onTab: () async {
        await datePickerHelper(
          context: context,
          initialDate: _selectedDate,
          firstDate: firstDate ?? DateTime.now(),
          lastDate: lastDate ?? DateTime.now().add(const Duration(days: 30)),
          onSelected: (DateTime selectedDate) {
            _selectedDate = selectedDate;

            controller!.value = TextEditingValue(
              text: DateFormat("yyyy-MM-dd").format(selectedDate),
            );

            if (onTap != null) {
              onTap!();
            }
          },
        );
      },
      keyboardType: TextInputType.datetime,
      controller: controller,
      focusNode: AlwaysDisabledFocusNode(),
      nextNode: nextNode,
      suffix: const Icon(CupertinoIcons.calendar_badge_plus),
    );
  }
}
