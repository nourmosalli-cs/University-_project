import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearch;

  const SearchWidget({
    Key? key,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onSearch, // When text changes, call onSearch
              decoration: InputDecoration(
                hintText: 'Search here',
                filled: true,
                fillColor: const Color.fromRGBO(240, 246, 246, 1),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          controller.clear(); // Clear the text field
                          onSearch(''); // Call onSearch to update the filter
                        },
                      )
                    : const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 1, color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 1, color: Colors.transparent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
