// action_buttons.dart
import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/widgets/accordion/expandable_tile_section.dart';


class ActionButton {
  final Icon icon;
  final String label;
  final Color bgcolor;
  final Color color;
  final VoidCallback onPressed;

  ActionButton({
    required this.icon,
    required this.label,
    required this.bgcolor,
    required this.color,
    required this.onPressed,
  });
}

class ActionButtonsRow extends StatelessWidget {
  final List<ActionButton> actionButtons;

  ActionButtonsRow({required this.actionButtons});

  @override
  Widget build(BuildContext context) {
    final dividedButtons = <Widget>[];

    for (var i = 0; i < actionButtons.length; i += 2) {
      final firstButton = actionButtons[i];
      final secondButton = i + 1 < actionButtons.length ? actionButtons[i + 1] : null;

      final rowChildren = <Widget>[
        Expanded(
          child: TextButtonWidget(
            icon: firstButton.icon,
            text: Text(
              firstButton.label,
              style: TextStyle(
                color: firstButton.color,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(firstButton.bgcolor),
            ),
            onPressed: firstButton.onPressed,
          ),
        ),
      ];

      if (secondButton != null) {
        rowChildren.add(SizedBox(width: 8)); // Spacer antara tombol pertama dan kedua
        rowChildren.add(
          Expanded(
            child: TextButtonWidget(
              icon: secondButton.icon,
              text: Text(
                secondButton.label,
                style: TextStyle(
                  color: secondButton.color,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(secondButton.bgcolor),
              ),
              onPressed: secondButton.onPressed,
            ),
          ),
        );
      }

      dividedButtons.add(
        Row(
          children: rowChildren,
        ),
      );
    }

    return Column(
      children: dividedButtons,
    );
  }
}
