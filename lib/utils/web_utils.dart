import 'dart:html' as html;

void enterFullScreen() {
  html.document.documentElement!.requestFullscreen();
}

void exitFullScreen() {
  html.document.exitFullscreen();
}
