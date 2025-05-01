part of '../participant_view.dart';

class _AddParticipantRow extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController bibController;
  final VoidCallback onAdd;

  const _AddParticipantRow({
    required this.nameController,
    required this.bibController,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: TextField(
            controller: bibController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Bib",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 250,
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "Name",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          height: 48,
          width: 48,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: onAdd,
          ),
        ),
      ],
    );
  }
}
