import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';

class KittingStatusWidget extends StatefulWidget {
  const KittingStatusWidget({super.key});

  @override
  State<KittingStatusWidget> createState() => _KittingStatusWidgetState();
}

class _KittingStatusWidgetState extends State<KittingStatusWidget> {
  int activeStep = 0;

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: activeStep,
      stepShape: StepShape.rRectangle,
      stepBorderRadius: 15,
      borderThickness: 2,
      stepRadius: 16,
      showTitle: false,
      padding: EdgeInsets.zero,
      showLoadingAnimation: false,
      steps: [
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 0 ? 1 : 0.3,
              child: Assets.images.kitting.image(),
            ),
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 1 ? 1 : 0.3,
              child: Assets.images.checkKitting.image(),
            ),
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 2 ? 1 : 0.3,
              child: Assets.images.icSupply.image(),
            ),
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 3 ? 1 : 0.3,
              child: Assets.images.icSupply.image(),
            ),
          ),
        ),
      ],
      onStepReached: (index) => setState(() {
        activeStep = index;
      }),
    );
  }
}
