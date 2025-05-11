part of '../result_view.dart';

class _ResultTable extends StatelessWidget {
  const _ResultTable({required this.viewModel});

  final ResultViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final rankedUsers = viewModel.getRankedParticipants();

    return DataTable(
      columns: [
        DataColumn(label: Text('Rank')),
        DataColumn(label: Text('Bib')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('FinishAt')),
      ],
      rows:
          rankedUsers.asMap().entries.map((entry) {
            final index = entry.key;
            final user = entry.value;
            Duration? totalTime = viewModel.getTotalTime(user);
            return DataRow(
              cells: [
                DataCell(
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 60),
                    child: Text((index + 1).toString()),
                  ),
                ),
                DataCell(
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 80),
                    child: Text(user.bibNumber.toString()),
                  ),
                ),
                DataCell(
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 150),
                    child: Text(user.name),
                  ),
                ),
                DataCell(
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 120),
                    child: Text(
                      totalTime != null ? formatTotalTime(totalTime) : 'N/A',
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }
}
