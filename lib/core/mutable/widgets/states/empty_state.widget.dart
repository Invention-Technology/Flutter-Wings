import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../immutable/providers/errors/error.model.wings.dart';

class WingsEmptyState extends StatelessWidget {
  final ErrorModel? error;
  final bool searchError;

  const WingsEmptyState({
    Key? key,
    this.error,
    this.searchError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!searchError) const Spacer(),
            if (error != null && error!.icon.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: constraint.maxHeight * 0.05),
                child: SvgPicture.asset(
                  error!.icon,
                  height: constraint.maxHeight * 0.4,
                ),
              ),
            if (error != null)
              Text(
                error!.message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    // color: AppLightTheme.primaryColor.withOpacity(.2),
                    height: 1.4,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            if (!searchError) const Spacer(),
          ],
        ),
      );
    });
  }
}
