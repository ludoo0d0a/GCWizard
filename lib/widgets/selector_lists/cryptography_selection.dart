import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';

class CryptographySelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {

    final List<GCWToolWidget> _toolList = Registry.toolList.where((element) => element.category == ToolCategory.CRYPTOGRAPHY).toList();

    return Container(
      child: GCWToolList(
        toolList: _toolList
      )
    );
  }
}