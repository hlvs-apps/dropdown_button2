import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

/// A specialized [SliverChildBuilderDelegate] that builds children for slivers
/// with separators between them.
class SeparatedSliverChildBuilderDelegate extends SliverChildBuilderDelegate {
  /// Creates a delegate that supplies children for slivers using the given
  /// [itemBuilder] callback. The children are separated by separators,
  /// built using the given [separatorBuilder] callback.
  ///
  /// The `itemBuilder` callback will be called with indices greater than
  /// or equal to zero and less than [itemCount].
  ///
  /// Separators only appear between children built by the `itemBuilder`:
  /// The first separator appears after the first item
  /// and the last separator appears before the last item.
  ///
  /// The `separatorBuilder` callback will be called with indices greater than
  /// or equal to zero and less than `itemCount - 1`.
  ///
  /// The `itemBuilder`, `itemCount`, `separatorBuilder`, [addAutomaticKeepAlives],
  /// [addRepaintBoundaries], [addSemanticIndexes], and [semanticIndexCallback]
  /// arguments must not be null.
  ///
  /// If the order in which `itemBuilder` returns children ever changes, consider
  /// providing a [findChildIndexCallback]. This allows the delegate to find the
  /// new index for a child that was previously located at a different index to
  /// attach the existing state to the [Widget] at its new location.
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildBuilderDelegate.addAutomaticKeepAlives] property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildBuilderDelegate.addRepaintBoundaries] property. The
  /// `addSemanticIndexes` argument corresponds to the
  /// [SliverChildBuilderDelegate.addSemanticIndexes] property. None may be
  /// null.
  SeparatedSliverChildBuilderDelegate({
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    required IndexedWidgetBuilder separatorBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    ChildIndexGetter? findChildIndexCallback,
  }) : super(
          (BuildContext context, int index) {
            final itemIndex = index ~/ 2;

            if (index.isEven) {
              return itemBuilder(context, itemIndex);
            }

            final widget = separatorBuilder(context, itemIndex);

            return widget;
          },
          findChildIndexCallback: findChildIndexCallback,
          childCount: computeActualChildCount(itemCount),
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: (Widget _, int index) {
            return index.isEven ? index ~/ 2 : null;
          },
        );

  /// Computes the actual child count from the given item count, taking into account separators.
  /// It returns the actual child count, excluding separators.
  static int computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }
}
