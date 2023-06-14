import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wings/core/mutable/helpers/bottomSheet.helper.dart';
import 'package:wings/core/mutable/widgets/button.widget.dart';

import '../../immutable/main.wings.dart';
import '../themes/theme.wings.dart';

dynamic confirmationBottomSheet({
  required Function onSave,
  Function? onCancel,
  required String title,
  String subtitle = '',
  bool danger = false,
  String? acceptText,
  String? cancelText,
}) {
  return bottomSheetHelper(
    builder: (context) {
      return SafeArea(
        child: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ).copyWith(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title.isNotEmpty) SizedBox(height: 0.05.sh),
                    Text(
                      title,
                      style: WingsTheme.heading,
                    ),
                    if (subtitle.isNotEmpty) SizedBox(height: 0.025.sh),
                    Text(
                      subtitle,
                      style: WingsTheme.body1,
                    ),
                    if (title.isNotEmpty) SizedBox(height: 0.075.sh),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonWidget(
                            text: acceptText ?? 'موافق',
                            onClick: () async {
                              Wings.closeWidget();
                              await onSave();
                            },
                            bgColor: danger
                                ? WingsTheme.dangerLightColor
                                : WingsTheme.primaryColor,
                            textColor: danger
                                ? WingsTheme.dangerDarkColor
                                : Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.01.sh),
                            child: ButtonWidget(
                              text: cancelText ?? 'إلغاء',
                              primaryStyle: false,
                              onClick: () {
                                Wings.closeWidget();
                                if (onCancel != null) {
                                  onCancel();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
