import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const SearchTextField({Key? key, required this.onChanged}) : super(key: key);

  @override
  SearchTextFieldState createState() => SearchTextFieldState();
}

class SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: 'Search title. Eg: Moon',
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        suffixIcon: _textEditingController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _textEditingController.clear();
                    widget.onChanged('');
                  });
                },
              )
            : null,
      ),
      onChanged: widget.onChanged,
    );
  }
}
