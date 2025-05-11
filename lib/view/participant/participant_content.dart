part of 'participant_view.dart';

class _ParticipantContent extends StatelessWidget {
  const _ParticipantContent({required this.viewModel});

  final ParticipantViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final bibController = TextEditingController();

    Widget content = Text('No user found');

    if (viewModel.isLoading) {
      content = Center(child: CircularProgressIndicator());
    } else {
      content = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _SearchField(onChanged: viewModel.searchParticipant),
            const SizedBox(height: 10),
            _ParticipantTable(viewModel: viewModel),
            const SizedBox(height: 12),
            _AddParticipantRow(
              nameController: nameController,
              bibController: bibController,
              onAdd: () {
                final name = nameController.text.trim();
                final bib = bibController.text.trim();
                if (name.isNotEmpty && bib.isNotEmpty) {
                  final newUser = User(name: name, bibNumber: bib);
                  viewModel.addUser(newUser);
                  nameController.clear();
                  bibController.clear();
                  SnackBarHelper.showRaceSnackBar(
                    context,
                    "Participant added successfully",
                    SnackBarType.success,
                  );
                }
              },
            ),
          ],
        ),
      );
    }

    return content;
  }
}
