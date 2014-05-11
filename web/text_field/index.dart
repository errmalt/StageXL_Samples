library text_field;

import 'dart:async';
import 'dart:html' as html;
import 'dart:math' as math;
import 'package:stagexl/stagexl.dart';

part 'source/font.dart';
part 'source/font_tester.dart';
part 'source/font_manager.dart';

part 'source/text_game_on.dart';
part 'source/text_game_over.dart';
part 'source/text_get_ready.dart';
part 'source/text_hold_the_line.dart';
part 'source/text_hot_and_spicy.dart';
part 'source/text_sugar_smash.dart';
part 'source/text_sweet.dart';
part 'source/text_you_win.dart';

Stage stage = new Stage(html.querySelector('#stage'), webGL: true);
RenderLoop renderLoop = new RenderLoop();
DisplayObject currentText = new Sprite();
DisplayObject currentTextCached = new Sprite();

void main() {

  renderLoop.addStage(stage);

  // Please note that this FontManager is experimental! We are still
  // investigating the best way to load fonts and want to add it to
  // the ResourceManager class in StageXL.

  FontManager fontManager = new FontManager()
      ..addGoogleFont('Poller One')
      ..addGoogleFont('Titillium Web', 900)
      ..addGoogleFont('Parisienne')
      ..addGoogleFont('Varela Round')
      ..addGoogleFont('Poly')
      ..addGoogleFont('Ceviche One')
      ..addGoogleFont('Press Start 2P')
      ..addGoogleFont('Norican')
      ..addGoogleFont('Yanone Kaffeesatz')
      ..addGoogleFont('VT323');

  fontManager.load().then((_) => start());
}

start() {

  var textGameOn = new TextGameOn();
  var textGameOver = new TextGameOver();
  var textGetReady = new TextGetReady();
  var textHoldTheLine = new TextHoldTheLine();
  var textHotAndSpicy = new TextHotAndSpicy();
  var textSugarSmash = new TextSugarSmash();
  var textSweet = new TextSweet();
  var textYouWin = new TextYouWin();

  html.querySelector("#btnGameOn").onClick.listen((_) => showText(textGameOn));
  html.querySelector("#btnGameOver").onClick.listen((_) => showText(textGameOver));
  html.querySelector("#btnGetReady").onClick.listen((_) => showText(textGetReady));
  html.querySelector("#btnHoldTheLine").onClick.listen((_) => showText(textHoldTheLine));
  html.querySelector("#btnHotAndSpicy").onClick.listen((_) => showText(textHotAndSpicy));
  html.querySelector("#btnSugarSmash").onClick.listen((_) => showText(textSugarSmash));
  html.querySelector("#btnSweet").onClick.listen((_) => showText(textSweet));
  html.querySelector("#btnYouWin").onClick.listen((_) => showText(textYouWin));

  showText(textSugarSmash);
}

void showText(DisplayObject text) {

  if (currentText == text) return;

  var bounds = text.getBounds(text);
  text.pivotX = bounds.center.x;
  text.pivotY = bounds.center.y;
  text.width = 600;
  text.scaleY = text.scaleX;

  var oldTextCached = currentTextCached;
  stage.juggler.tween(oldTextCached, 0.5, TransitionFunction.easeInQuartic)
      ..animate.x.by(800)
      ..onComplete = () {
        oldTextCached.removeFromParent();
        oldTextCached.removeCache();
      };

  currentText = text;
  currentTextCached = new Sprite()
      ..x = 740 / 2 - 800
      ..y = 500 / 2
      ..addChild(currentText)
      ..addTo(stage);

  var size = currentTextCached.getBounds(currentTextCached).align();
  currentTextCached.applyCache(size.left, size.top, size.width, size.height);

  stage.juggler.tween(currentTextCached, 0.5, TransitionFunction.easeOutQuartic)
      ..delay = 0.4
      ..animate.x.by(800);
}