import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:smart_warehouse/repositories/emap_repository.dart';
import 'package:smart_warehouse/services/models/response/map_trolley_response_model.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'trolley_map_html_controller.dart';
import 'trolley_map_html_state.dart';

@RoutePage()
class TrolleyMapHTMLPage
    extends BasePage<TrolleyMapHTMLController, TrolleyMapHTMLState> {
  const TrolleyMapHTMLPage({
    super.key,
    required this.trolleyCode,
    required this.kittingListId,
  });

  final int kittingListId;
  final String trolleyCode;

  @override
  BasePageState createState() {
    return _TrolleyMapHTMLState();
  }
}

class _TrolleyMapHTMLState
    extends BasePageState<TrolleyMapHTMLController, TrolleyMapHTMLState> {
  // late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final trolleyCode = widget.as<TrolleyMapHTMLPage>()?.trolleyCode ?? '';
    final kittingListId = widget.as<TrolleyMapHTMLPage>()?.kittingListId ?? 0;
    context.read<TrolleyMapHTMLController>().loadTrolleyMap(
          trolleyCode: trolleyCode,
          kittingListId: kittingListId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Map Trolley'),
      ),
      body: BlocBuilder<TrolleyMapHTMLController, TrolleyMapHTMLState>(
        buildWhen: (prev, current){
          return prev.trolleyMapData  != current.trolleyMapData;
        },
        builder: (context, state) {
          if(state.trolleyMapData != null){
            return const SizedBox();
          }
          return HtmlWidget(
            state.trolleyMapData?.content ?? '',
            customStylesBuilder: (element) {
              switch (element.localName) {
                case 'table':
                  return {
                    'border': '1px solid black',
                    'border-collapse': 'collapse',
                  };
                case 'td':
                  return {
                    'border': '1px solid black',
                    'border-collapse': 'collapse',
                    'padding': '2px 4px',
                  };
              }
              return null;
            },
          );
        },
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No back history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            if (await webViewController.canGoForward()) {
              await webViewController.goForward();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No forward history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () => webViewController.reload(),
        ),
      ],
    );
  }
}
