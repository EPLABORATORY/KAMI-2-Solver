class Block {
  PVector[] points = new PVector [3]; 
  int Color;
  boolean Selected = false;
  PShape triangle;

  Block() {
    points[0] = new PVector(0.0, 0.0, 0.0);
    points[1] = new PVector(0.0, 0.0, 0.0);
    points[2] = new PVector(0.0, 0.0, 0.0);
  }


  void draw() {
    triangle = new PShape(PShape.PATH);
    triangle.vertex(points[0].x,points[0].y);
    triangle.vertex(points[1].x,points[1].y);
    triangle.vertex(points[2].x,points[2].y);
    if(triangle.contains(mouseX,mouseY)){Selected = true;} else {Selected = false;}

    if (Selected == true)  fill(colors[Color] - 50);
    else fill(colors[Color]);
    triangle(points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y);
    fill(0, 0, 0);
   // ellipse(points[0].x, points[0].y, 10, 10); 
   // ellipse(points[1].x, points[1].y, 10, 10); 
   // ellipse(points[2].x, points[2].y, 10, 10);
  }
}


int xnum = 10; //10 
int ynum = 29 ; //29
float sy = 20;
float sx = sy*sqrt(3);
float xpos = 360.0;
float ypos = 10;
boolean left = true;
float vertexX = 0;
float vertexY = 0; 
Block[] Blocks; 

float vx0 = 0;
float vy0 = 0;
float vx1 = 0;
float vy1 = 0;
float vx2 = 0;
float vy2 = 0;


void setupGrid() {
  //Load Colors!

  String[] lines = loadStrings("list.txt");
  println("there are " + lines.length + " lines");

  Blocks = new Block[xnum*ynum];
  for (int i = 0; i < xnum*ynum; i++) {
    Blocks[i] = new Block();
  }
  println("Number of triangles:", xnum*ynum);
  int count = 0;
  for (int col = 0; col < xnum; col++) {
    for (int row = 1; row <= ynum + 2; row++) {    
      if (col % 2 == 0) {
        if (row % 2 != 0) {
          //vertex(0+xpos+(col*sx),((row-1)*sy)+ypos);
          vertexX = 0+xpos+(col*sx);
          vertexY = ((row-1)*sy)+ypos;
        } else {
          //vertex(sx+xpos+(col*sx),((row-1)*sy)+ypos);
          vertexX = sx+xpos+(col*sx);
          vertexY = ((row-1)*sy)+ypos;
        }
      } else {
        if (row % 2 != 0) {
          //vertex(sx+xpos+(col*sx),((row-1)*sy)+ypos);
          vertexX = sx+xpos+(col*sx);
          vertexY = ((row-1)*sy)+ypos;
        } else {
          //vertex(0+xpos+(col*sx),((row-1)*sy)+ypos);
          vertexX = 0+xpos+(col*sx);
          vertexY = ((row-1)*sy)+ypos;
        }
      }
      vx0 = vx1;
      vy0 = vy1;
      vx1 = vx2;
      vy1 = vy2;
      vx2 = vertexX;
      vy2 = vertexY;

      if (row >= 3) {
        fill(100, 100, 100);
        //println(count,vx0,vy0,vx1,vy1,vx2,vy2);     
        Blocks[count].points[0].x = vx0;
        Blocks[count].points[0].y = vy0;
        Blocks[count].points[1].x = vx1;
        Blocks[count].points[1].y = vy1;
        Blocks[count].points[2].x = vx2;
        Blocks[count].points[2].y = vy2;
        Blocks[count].Color = int(lines[count]); //color(random(100,150));
        count++;
      }
    }
  }
}

int ColorRecognition(color c)
{
  float min = 5000000;
  int mindex = -1;
  float value = 0;
  for (int i = 0; i < NOC; i++) {
    value = abs((abs(red(c)) - abs(red(colors[i]))) + (abs(green(c)) - abs(green(colors[i]))) + (abs(blue(c)) - abs(blue(colors[i]))));  
    if (value <= min) {
      min = value;
      mindex = i;
    }
  } 
  //println("Closest match is:",value,mindex);
  return mindex;
}