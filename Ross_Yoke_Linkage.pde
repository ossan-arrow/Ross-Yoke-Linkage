final float k = 9.0;  // 倍率
final float Ri = k * 35;  // フライホイール外径
final float Ro = k * 28;  // フライホイール内径
final float Rb = k * 2.0;  // 軸受内径
final float r = k * 5.0;  // 回転半径
final float Ls = k * 42.0;  // 支持リンク長さ
final float Lc = k * 20.0;  // 逆T字クランク縦長さ
final float Lph = k * 20.0;  // 逆T字クランク横長さ（半分）
final float Lp = k * 20.0;  // ピストン連接棒長さ
final float w1 = k * 12.4;
final float h1 = k * 13.0;
final float w2 = k * 15.0;
final float h2 = k * 18.0;
final float X0 = (Ls + sqrt(pow(Ls, 2.0) - pow(r, 2.0))) * 0.5;
final float Y0 = Lc;
float X1, Y1;
float X2, Y2;
float Xh, Yh;
float Xc, Yc;
float Yph, Ypc;
float a;
float phi;
float t1, t2;
float t = 0.0;
float v = 0.0;
int rpm = 0;

void setup() {
  size(900, 600);
  frameRate(60);
  smooth();
  rectMode(CENTER);
}

void draw() {
  background(128);
  translate(width / 2, height * 2 / 5);

  X1 = r * sin(radians(t));
  Y1 = r * cos(radians(t));
  a = sqrt(pow(X1 - X0, 2.0) + pow(Y1 - Y0, 2.0));
  phi = atan((Y0 - Y1) / (X0 - X1));
  t1 = acos((pow(a, 2.0) + pow(Lc, 2.0) - pow(Ls, 2.0)) / (2.0 * a * Lc));
  X2 = X1 + Lc * cos(t1 + phi);
  Y2 = Y1 + Lc * sin(t1 + phi);
  t2 = HALF_PI - t1 - phi;
  Xc = X2 + Lph * cos(t2);
  Yc = Y2 - Lph * sin(t2);
  Xh = X2 - Lph * cos(t2);
  Yh = Y2 + Lph * sin(t2);
  Yph = Yh - sqrt(pow(Lp, 2.0) - pow(Lph + Xh, 2.0));
  Ypc = Yc - sqrt(pow(Lp, 2.0) - pow(Lph - Xc, 2.0));

  ellipse(0, 0, Ri, Ri);
  ellipse(0, 0, Ro, Ro);
  ellipse(0, 0, k * 7.0, k * 7.0);
  ellipse(0, 0, k * 3.0, k * 3.0);
  line(0.5 * Ro * sin(radians(t)), 0.5 * Ro * cos(radians(t)), 0.5 * Ri * sin(radians(t)), 0.5 * Ri * cos(radians(t)));
  line(X1, Y1, X2, Y2);
  line(X0, Y0, X2, Y2);
  line(Xh, Yh, Xc, Yc);
  rect(-Lph, Yph, w1, h1);
  rect(Lph, Ypc, w2, h2);
  line(Xh, Yh, -Lph, Yph);
  line(Xc, Yc, Lph, Ypc);
  ellipse(X0, Y0, Rb, Rb);
  ellipse(X1, Y1, Rb, Rb);
  ellipse(X2, Y2, Rb, Rb);
  ellipse(Xc, Yc, Rb, Rb);
  ellipse(Xh, Yh, Rb, Rb);
  ellipse(-Lph, Yph, Rb, Rb);
  ellipse(Lph, Ypc, Rb, Rb);

  t += v;
  if (t >= 360.0) {
    t -= 360.0;
  }
  if (keyPressed) {
    if (keyCode == UP) {
      v += 0.1;
    } else if (keyCode == DOWN) {
      v -= 0.1;
    } else if (key == ' ') {
      v = 0.0;
    }
  }
  rpm = (int)(v * 10.0);
  textAlign(LEFT);
  text(rpm + " rpm", -420, 320);
}

