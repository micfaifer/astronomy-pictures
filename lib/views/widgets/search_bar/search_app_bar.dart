import 'package:astronomy_pictures/views/widgets/search_bar/search_text_field.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final ValueChanged<String> onSearchTextChanged;

  const SearchAppBar({
    Key? key,
    required this.actions,
    required this.onSearchTextChanged,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.all(10),
        child: SearchTextField(
          onChanged: onSearchTextChanged,
        ),
      ),
      actions: actions,
    );
  }
}
