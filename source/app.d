import std.stdio;
import raylib;

struct Circle
{
  Vector2 position;
  int xSpeed;
  int ySpeed;
  float radius;
  const Colors color;
}

// problem with values passed into CheckCollisionCircles?
// bool checkCollisions(Circle circle, Circle[] circles)
// {
//   foreach (int i; circles)
//   {
//     if (circle.position == circles[i].position)
//     {
//       continue;
//     }
//     if (CheckCollisionCircles(circle.position, circle.radius,
//         circles[i].position, circles[i].radius) == true)
//     {
//       return true;
//     }
//   }
//   return false;
// }

void main()
{
  writeln("Starting a raylib example.");

  Circle blueCircle = Circle(Vector2(400f, 320f), 5, 5, 20f, Colors.BLUE);
  Circle redCircle = Circle(Vector2(200f, 500f), -7, -14, 10f, Colors.RED);
  Circle blackCircle = Circle(Vector2(400f, 300f), 7, 4, 80f, Colors.BLACK);
  Circle magentaCircle = Circle(Vector2(200f, 300f), -7, -4, 80f, Colors.MAGENTA);
  Circle maroonCircle = Circle(Vector2(400f, 320f), -5, -5, 20f, Colors.MAROON);

  // Dyanmic arrays pass by value, by default.
  // Creating an array of Circle pointers and passing in the memory addresses
  // of the Circle struct instances allows me to access them through the array later
  Circle*[] circles = [&blueCircle, &redCircle, &blackCircle, &magentaCircle, &maroonCircle];

  SetTargetFPS(60);
  InitWindow(800, 640, "Hello, World!");
  scope (exit)
    CloseWindow(); // see https://dlang.org/spec/statement.html#scope-guard-statement

  while (!WindowShouldClose())
  {

    // Updating
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

      //checkCollisions(circle, circles);
    }

    // Create a function to loop through each circle, looking for collision
    if (CheckCollisionCircles(blackCircle.position, blackCircle.radius,
        magentaCircle.position, magentaCircle.radius))
    {
      blackCircle.xSpeed = -blackCircle.xSpeed;
      blackCircle.ySpeed = -blackCircle.ySpeed;
      magentaCircle.xSpeed = -magentaCircle.xSpeed;
      magentaCircle.ySpeed = -magentaCircle.ySpeed;
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
