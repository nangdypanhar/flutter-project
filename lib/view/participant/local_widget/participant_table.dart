part of '../participant_view.dart';

class _ParticipantTable extends StatelessWidget {
  const _ParticipantTable({required this.viewModel});

  final ParticipantViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columnSpacing: 16,
          columns: const [
            DataColumn(label: Text('Bib')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Action')),
          ],
          rows:
              viewModel.userList.map((user) {
                bool isEditing = viewModel.isEditing(user);
                final bibController = TextEditingController(
                  text: user.bibNumber,
                );
                final nameController = TextEditingController(text: user.name);

                return DataRow(
                  cells: [
                    DataCell(
                      isEditing
                          ? TextField(
                            onTap: () => FocusScope.of(context).unfocus(),
                            controller: bibController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          )
                          : Text(user.bibNumber),
                    ),
                    DataCell(
                      isEditing
                          ? TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          )
                          : Text(user.name),
                    ),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isEditing ? Icons.save : Icons.edit,
                              color: isEditing ? Colors.green : Colors.blue,
                            ),
                            onPressed: () {
                              if (isEditing) {
                                final updatedUser = user.copyWith(
                                  bibNumber: bibController.text.trim(),
                                  name: nameController.text.trim(),
                                );
                                viewModel.saveEditing(updatedUser);
                                SnackBarHelper.showRaceSnackBar(
                                  context,
                                  "Participant updated successfully",
                                  SnackBarType.success,
                                );
                              } else {
                                viewModel.startEditing(user);
                              }
                            },
                            padding: EdgeInsets.all(8.0),
                            iconSize: 24.0,
                            splashColor: Colors.grey[200],
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed:
                                () => ConfirmDialog(
                                  onConfirm:
                                      () => viewModel.deleteUser(user),
                                ).show(context),
                            padding: EdgeInsets.all(8.0),
                            iconSize: 24.0,
                            splashColor: Colors.grey[200],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
