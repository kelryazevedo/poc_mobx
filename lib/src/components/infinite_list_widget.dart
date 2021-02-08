import 'package:flutter/material.dart';
import 'package:poc_mobx/src/utils/colors_style.dart';

class InfiniteListWidget extends StatefulWidget {
  final double scrollThreshold;
  final Function nextData;
  final bool hasNext;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final String noResultString;
  final Key key;

  final Widget headerList;

  const InfiniteListWidget({
    @required this.itemBuilder,
    @required this.itemCount,
    @required this.nextData,
    this.padding,
    this.margin,
    this.physics,
    this.shrinkWrap = false,
    this.scrollThreshold = 300,
    this.hasNext = false,
    this.headerList,
    this.noResultString, this.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _InfiniteListWidgetState();
  }
}

class _InfiniteListWidgetState extends State<InfiniteListWidget> {
  ScrollController _scrollController = ScrollController();
  int _lastLoadedEvent;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(InfiniteListWidget oldWidget) {
    if (oldWidget.itemCount != widget.itemCount) {
      _lastLoadedEvent = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  bool _hasScroll() {
    return _scrollController.position.maxScrollExtent != null &&
        _scrollController.position.maxScrollExtent > 0;
  }

  @override
  Widget build(BuildContext context) {
    final itemBuilder = (BuildContext context, int index) {
      if (this.widget.itemCount == 0) return this._buildSemResultado();

      if (!_hasScroll() &&
          index == widget.itemCount &&
          _lastLoadedEvent == null &&
          widget.hasNext) {
        _lastLoadedEvent = widget.itemCount;
        WidgetsBinding.instance.addPostFrameCallback((_) => widget.nextData());
      }

      if (index == 0 && this.widget.headerList != null)
        return this.widget.headerList;
      else if (index == widget.itemCount)
        return this._buildLoadingFooter();
      else
        return widget.itemBuilder(context, index);
    };

    return Container(
      margin: this.widget.margin,
      child: ListView.builder(
        key: widget.key,
        itemBuilder: itemBuilder,
        controller: _scrollController,
        padding: widget.padding,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        itemCount: this.getItemCount(),
      ),
    );
  }

  int getItemCount() {
    var totalCount = widget.itemCount != 0 ? widget.itemCount : 1;
    if (widget.hasNext) totalCount += 1;
    if (widget.headerList != null) totalCount += 1;
    return totalCount;
  }

  Widget _buildLoadingFooter() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
            ColorsStyle.blue,
          ),
          backgroundColor: ColorsStyle.blue,
        ),
      ),
    );
  }

  Widget _buildSemResultado() {
    if (this.widget.noResultString == null) return SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(24),
      child: Text(
        this.widget.noResultString,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorsStyle.blue,
          fontSize: 17,
        ),
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= widget.scrollThreshold &&
        _lastLoadedEvent == null &&
        widget.hasNext) {
      _lastLoadedEvent = widget.itemCount;
      widget.nextData();
    }
  }
}
