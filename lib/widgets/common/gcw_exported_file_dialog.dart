import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/theme/theme.dart';

showExportedFileDialog(BuildContext context, String filePath, {Widget contentWidget, int dialogHeight}) {
  showGCWDialog(
    context,
    i18n(context, 'common_exportfile_saved'),
    Column(
      children: [
        GCWText(
          text: i18n(context, 'common_exportfile_savepath', parameters: [filePath]),
          style: gcwTextStyle().copyWith(color: themeColors().dialogText()),
        ),
        contentWidget == null ? Container() : contentWidget
      ],
    ),
    [
      GCWDialogButton(
        text: i18n(context, 'common_exportfile_sharefile'),
        onPressed: () {
          //TODO
        },
      ),
      GCWDialogButton(
        text: i18n(context, 'common_exportfile_openfile'),
        onPressed: () {
          //TODO
        },
      ),
      GCWDialogButton(
        text: i18n(context, 'common_ok'),
      )
    ],
    cancelButton: false
  );
}