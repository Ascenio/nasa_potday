import 'package:flutter/material.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/date_as_text_widget.dart';

enum SearchMode {
  normal,
  text,
  date,
}

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({
    required this.onReset,
    required this.onTextSearch,
    required this.onDateSearch,
    super.key,
  });

  final VoidCallback onReset;
  final ValueChanged<String> onTextSearch;
  final ValueChanged<DateTime> onDateSearch;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  SearchMode mode = SearchMode.normal;
  final controller = TextEditingController();
  DateTime? date;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void reset() {
    setState(() {
      mode = SearchMode.normal;
      controller.clear();
      date = null;
    });
    widget.onReset();
  }

  void onSearchStart() {
    setState(() {
      mode = SearchMode.text;
    });
  }

  Future<void> onCalendarPressed() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1995, DateTime.june, 16),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        mode = SearchMode.date;
        this.date = date;
      });
      widget.onDateSearch(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final changeToNormalButton = IconButton(
      icon: const Icon(
        Icons.chevron_left,
      ),
      onPressed: reset,
    );
    Widget child = switch (mode) {
      SearchMode.normal => AppBar(
          title: const Text('Picture of the day'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
              ),
              onPressed: onSearchStart,
            ),
            IconButton(
              icon: const Icon(
                Icons.today,
              ),
              onPressed: onCalendarPressed,
            )
          ],
        ),
      SearchMode.text => AppBar(
          leading: changeToNormalButton,
          title: TextField(
            controller: controller,
            onChanged: widget.onTextSearch,
            autofocus: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      SearchMode.date => AppBar(
          leading: changeToNormalButton,
          title: DateAsTextWidget(date: date!),
        ),
    };
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: KeyedSubtree(
        key: ValueKey(mode),
        child: child,
      ),
    );
  }
}
