part of 'result_view.dart';

class _ResultContent extends StatelessWidget {
  const _ResultContent({required this.viewModel});

  final ResultViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    Widget content = Text('No user found');

    if (viewModel.isLoading) {
      content = Center(child: CircularProgressIndicator());
    } else {
      content = Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [_ResultTable(viewModel: viewModel)]),
      );
    }
    return content;
  }
}
