import std.stdio, std.math;
import raylib;

struct Circle
{
  static int count = 0;

  int id;
  Vector2 position;
  int xSpeed;
  int ySpeed;
  float radius;
  Colors color;

  this(Vector2 position, int xSpeed, int ySpeed, float radius, Colors color)
  {

    this.position = position;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
    this.radius = radius;
    this.color = color;

    id = count++;
  }
}

void checkCollisions(Circle[] circles)
{
  for (int i = 0; i < circles.length; i++)
  {
    foreach (ref Circle c; circles)
    {
      if (c.id == circles[i].id)
      {
        continue;
      }
      else if (CheckCollisionCircles(c.position, c.radius, circles[i].position, circles[i].radius))
      {
        handleCircleCollision(c, circles[i]);
      }
    }
  }
}

void handleCircleCollision(ref Circle c1, ref Circle c2)
{

  // possibly the dirtiest circle collision response ever.
  // handle x
  if (c1.position.x < c2.position.x)
  {
    c1.position.x -= 1;
    c2.position.x += 1;
    if (c1.xSpeed > 0 && c2.xSpeed < 0)
    {
      c1.xSpeed = -c1.xSpeed;
      c2.xSpeed = -c2.xSpeed;
    }
  }
  else {
    c2.position.x -= 1;
    c1.position.x += 1;
    if (c2.xSpeed > 0 && c1.xSpeed < 0)
    {
      c2.xSpeed = -c2.xSpeed;
      c1.xSpeed = -c1.xSpeed;
    }
  }
  // handle y
  if (c1.position.y < c2.position.y)
  {
    c1.position.y -= 1;
    c2.position.y += 1;
    if (c1.ySpeed > 0 && c2.ySpeed < 0)
    {
      c1.ySpeed = -c1.ySpeed;
      c2.ySpeed = -c2.ySpeed;
    }
  }
  else {
    c2.position.y -= 1;
    c1.position.y += 1;
    if (c2.ySpeed > 0 && c1.ySpeed < 0)
    {
      c2.ySpeed = -c2.ySpeed;
      c1.ySpeed = -c1.ySpeed;
    }
  }
}

void main()
{

  // dyanmic arrays pass by value, therefore these can be const since they're
  // 'not used' after creation
  const Circle blueCircle = Circle(Vector2(600f, 320f), 5, 5, 20f, Colors.BLUE);
  const Circle redCircle = Circle(Vector2(200f, 500f), -7, -14, 15f, Colors.RED);
  const Circle blackCircle = Circle(Vector2(400f, 300f), 7, 4, 40f, Colors.BLACK);
  const Circle magentaCircle = Circle(Vector2(200f, 300f), -7, -4, 30f, Colors.MAGENTA);
  const Circle maroonCircle = Circle(Vector2(400f, 120f), -5, -5, 20f, Colors.MAROON);

  Circle[] circles = [
    blueCircle, redCircle, blackCircle, magentaCircle, maroonCircle
  ];

  SetTargetFPS(60);
  InitWindow(800, 640, "Bouncing Balls!");
  scope (exit)
    CloseWindow(); // see https://dlang.org/spec/statement.html#scope-guard-statement

  while (!WindowShouldClose())
  {

    // Updating
    // stop circles going off-screen, update position by speed
    foreach (ref circle; circles)
    {
      if (circle.position.x > GetScreenWidth - circle.radius || circle.position.x < 0
          + circle.radius)
      {
        circle.xSpeed = -circle.xSpeed;
      }
      if (circle.position.y > GetScreenHeight - circle.radius || circle.position.y
          < 0 + circle.radius)
      {
        circle.ySpeed = -circle.ySpeed;
      }
      circle.position.x += circle.xSpeed;
      circle.position.y += circle.ySpeed;

    }
    // handles circle to circle collision
    checkCollisions(circles);

    // Drawing
    BeginDrawing();
    scope (exit)
      EndDrawing();

    ClearBackground(Colors.LIGHTGRAY);

    foreach (circle; circles)
    {
      DrawCircleV(circle.position, circle.radius, circle.color);
    }
  }
}
