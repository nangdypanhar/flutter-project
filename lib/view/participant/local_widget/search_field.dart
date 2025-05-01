
part of '../participant_view.dart';

class _SearchField extends StatelessWidget {
  final void Function(String)? onChanged;

  const _SearchField({this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "Search",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
