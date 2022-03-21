import 'package:flutteruibuilder/Editor/Bases/CanvasWidget/canvas_widget.dart';
import 'package:flutteruibuilder/Editor/Bases/WidgetController/widget_controller.dart';
import 'package:flutteruibuilder/Widgets/Wrap/fs_wrap_controller.dart';
import 'package:flutteruibuilder/Widgets/column/fs_column_controller.dart';
import 'package:flutteruibuilder/Widgets/container/fs_container_controller.dart';


class FSControllerUtil {
  static List<WidgetController>? getControllerOf(CanvasWidget widget) {
    switch (widget.fsWidget.runtimeType.toString()) {
      case "FSContainer":
        return FSContainerController.getControllers(widget.fsWidget!);

      case "FSColumn":
        return FSColumnController.getControllers(widget.fsWidget!); 
      
      case "FSIconButton":
        return null;

      case "FSRow":
        return null;

      case "FSStack":
        return null;

      case "FSText":
        return null;


      case "FSWrap":
        return FSWrapController.getControllers(widget.fsWidget!);

      default:
        return null;
    }
  }
}
