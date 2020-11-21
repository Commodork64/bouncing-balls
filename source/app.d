import std.stdio;
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

struct Result
{
  Circle circle1;
  Circle circle2;
  bool result;
}

// problem with values passed into CheckCollisionCircles?
Result checkCollisions(Circle[] circles)
{

  Result tempResult;

  // verify this code is actually working.
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
        return Result(c, circles[i], true);
      }
      else
      {
        tempResult = Result(c, circles[i], false);
      }
    }
  }

  return tempResult;
  // this should never be hit
  assert(0);
}

void handleCircleCollision(Circle c1, Circle c2)
{
  writef("Handling collisions");
}

void main()
{

  Circle blueCircle = Circle(Vector2(400f, 320f), 5, 5, 20f, Colors.BLUE);
  Circle redCircle = Circle(Vector2(200f, 500f), -7, -14, 10f, Colors.RED);
  Circle blackCircle = Circle(Vector2(400f, 300f), 7, 4, 80f, Colors.BLACK);
  Circle magentaCircle = Circle(Vector2(200f, 300f), -7, -4, 80f, Colors.MAGENTA);
  Circle maroonCircle = Circle(Vector2(400f, 320f), -5, -5, 20f, Colors.MAROON);

  // Dyanmic arrays pass by value, by default.
  // Creating an array of Circle pointers and passing in the memory addresses
  // of the Circle struct instances allows me to access them through the array later
  //Circle*[] circles = [&blueCircle, &redCircle, &blackCircle, &magentaCircle, &maroonCircle];
  // Had issues calling the pointer array with circle collision.
  // Pointers are supposed to be rare in D, probably doing it the wrong way, so should
  // use the dynamic array instead.
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
    // handles collision against walls
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

    Result collisResult = checkCollisions(circles);
    if(collisResult.result)
    {
      handleCircleCollision(collisResult.circle1, collisResult.circle2);
    }

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
