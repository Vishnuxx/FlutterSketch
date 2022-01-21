/* used by DragUtils.findWidgetAt functiont to return the touched widget anf its ancestor list*/

import 'package:flutteruibuilder/Bases/canvas_widgets.dart';
import 'package:flutteruibuilder/Bases/cw_holder.dart';

class TraversalData {
  CanvasWidget? canvasWidget;
  List<CanvasWidget>? parentList;

  TraversalData() {
    this.canvasWidget = null;
    this.parentList = null;
  }
}
