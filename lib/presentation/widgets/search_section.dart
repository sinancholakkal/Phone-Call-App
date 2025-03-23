import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoSearchTextField(padding: EdgeInsets.all(15)),
    );
  }
}
