import 'package:flutter/material.dart';

enum DrawingShape {
  brush,
  line,
  rectangle,
  circle,
}

DrawingShape type = DrawingShape.brush;

class MyCustomBrushPainter extends CustomPainter {
  List<List<Offset>> linesList;
  List<double> lineWidths;
  Offset offset;
  Offset offsetInit;
  List<Offset> pointsList;
  List<Color> lineColors;
  List<List<Offset>> undoLinesList; // Mover la inicialización aquí
  List<double> undoLineWidths;
  List<Color> undoLineColors;
  DrawingShape drawingShape; // Nueva variable para la forma de dibujo

  MyCustomBrushPainter({
    required this.linesList,
    required this.lineWidths,
    required this.offset,
    required this.offsetInit,
    required this.pointsList,
    required this.lineColors,
    required this.undoLinesList,
    required this.undoLineWidths,
    required this.undoLineColors,
    required this.drawingShape,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < linesList.length; i++) {
      final paintT = Paint()
        ..color = lineColors[i]
        ..strokeWidth = lineWidths[i]
        ..strokeCap = StrokeCap.round;

      if (drawingShape == DrawingShape.brush) {
        for (int j = 0; j < linesList[i].length - 1; j++) {
          if (linesList[i][j] != null && linesList[i][j + 1] != null) {
            canvas.drawLine(linesList[i][j], linesList[i][j + 1], paintT);
          }
        }
        // Dibujar línea actual en construcción con el color y grosor actual
        final paintT2 = Paint()
          ..color = lineColors[lineColors.length - 1]
          ..strokeWidth = lineWidths[lineWidths.length - 1]
          ..strokeCap = StrokeCap.round;
        for (int i = 0; i < pointsList.length - 1; i++) {
          if (pointsList[i] != null && pointsList[i + 1] != null) {
            canvas.drawLine(pointsList[i], pointsList[i + 1], paintT2);
          }
        }
      }

      if (drawingShape == DrawingShape.line) {
        // Dibujar línea recta
        if (linesList[i].isNotEmpty) {
          canvas.drawLine(
            linesList[i].first,
            linesList[i].last,
            paintT,
          );
        }
      }
      if (drawingShape == DrawingShape.rectangle) {
        // Dibujar rectángulo
        Paint paint = Paint()
          ..color = lineColors[i]
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = lineWidths[i];

        if (pointsList.isNotEmpty) {
          var al =
              Rect.fromPoints(pointsList[0], pointsList[pointsList.length - 1]);

          canvas.drawRect(al, paint);
        }
      } else if (drawingShape == DrawingShape.circle) {
        // Dibujar círculo
        if (pointsList.length >= 2) {
          final radius = (linesList[i].first - linesList[i].last).distance;
          canvas.drawCircle(pointsList[0], radius, paintT);
        }
      }
    }

    // Dibujar línea actual en construcción con el color y grosor actual

    if (drawingShape == DrawingShape.line) {
      final paintT2 = Paint()
        ..color = lineColors[lineColors.length - 1]
        ..strokeWidth = lineWidths[lineWidths.length - 1]
        ..strokeCap = StrokeCap.round;
      // Dibujar línea recta
      if (pointsList.isNotEmpty) {
        canvas.drawLine(
          pointsList.first,
          pointsList.last,
          paintT2,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  // Método para deshacer la última acción
  void undo() {
    if (linesList.isNotEmpty) {
      // Guardar las líneas, grosores de línea y colores en las listas de undo
      List<Offset> lastLine = linesList.removeLast();
      undoLinesList.add(lastLine);
      undoLineWidths.add(lineWidths.removeLast());
      undoLineColors.add(lineColors.removeLast());
      // Limpiar la lista de puntos actual
      pointsList.clear();
    }
  }

  // Método para rehacer la última acción deshecha
  void redo() {
    if (undoLinesList.isNotEmpty) {
      // Restaurar las líneas, grosores de línea y colores desde las listas de undo
      linesList.add(undoLinesList.removeLast());
      lineWidths.add(undoLineWidths.removeLast());
      lineColors.add(undoLineColors.removeLast());
      // Limpiar la lista de puntos actual
      pointsList.clear();
    }
  }
}
