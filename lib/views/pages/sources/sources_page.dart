import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/sources/bloc.dart';
import 'package:fomic/blocs/sources/event.dart';
import 'package:fomic/blocs/sources/state.dart';
import 'package:fomic/views/pages/source/source_page.dart';

class SourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (ctx) =>
          SourcesBloc()..dispatch(SourcesEvent(SourcesEventType.initSources)),
      child: _SourcesPage(),
    );
  }
}

class _SourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SourcesBloc>(context);
    return BlocBuilder<SourcesBloc, SourcesState>(
      builder: (ctx, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Sources'),
          ),
          body: SafeArea(
            child: ListView.builder(
              itemCount: state.sources.length,
              itemBuilder: (ctx, index) => ListTile(
                title: Text('${state.sources[index].name}'),
                trailing: Switch(
                  value: state.sources[index].available,
                  onChanged: (value) {
                    final event = SourcesEvent(
                      SourcesEventType.switchSourceState,
                      sourceId: state.sources[index].id,
                    );
                    bloc.dispatch(event);
                  },
                ),
                onTap: () {
                  final route = MaterialPageRoute<void>(builder: (ctx) {
                    final source = state.sources[index];
                    return SourcePage(source: source);
                  });
                  Navigator.of(ctx).push(route);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
