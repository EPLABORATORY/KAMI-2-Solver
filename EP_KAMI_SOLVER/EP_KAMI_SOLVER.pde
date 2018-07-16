PImage img;
float signal;
color[] colors = new color[10];
color c;
int NOC = 0;
boolean lock = false;
int selected = -1;



void setup() {
  size(800, 620,P2D);
  noFill();
  stroke(255);
  frameRate(30);
  img = loadImage("KAMI.jpg");
  img.resize(0, 600);
  setupGrid();
  background(0, 0, 0);
}

void draw() {

  if (mousePressed) {
    int mx = constrain(mouseX, 0, img.width-1);
    int my = constrain(mouseY, 0, img.height-1);

    signal = my*img.width + mx;
    int sx = int(signal) % img.width;
    int sy = int(signal) / img.width;
    c = img.get(sx, sy);
    println(ColorRecognition(c));
  } 
  if (keyPressed) {
    if (key == 's' || key =='S') {
      if (lock == false) {
        colors[NOC] = c;
        NOC++;
        lock = true;
      }
    }
    if (key == 'g' || key =='G') {
      for (int x = 0; x < 300; x = x + 10) {
        for (int y = 0; y < 300; y = y + 10) {
          img.set(x, y, 100);
        }
      }
    }

    if (key == ' ') {
      selected += 1;
      for (int i =0; i < Blocks.length; i++) {
        Blocks[i].Selected = false;
      }

      Blocks[selected].Selected = true;
    }

    if (key == 'c' || key =='C') {
      PrintWriter output;
      output = createWriter("list.txt");   
      for (int i =0; i < Blocks.length; i++) {
        output.println(Blocks[i].Color);
      }
      println("SAVED TO FILE!!!");
      output.flush(); // Writes the remaining data to the file
      output.close();
    }
    if (key == '0') Blocks[selected].Color = 0;
    if (key == '1') Blocks[selected].Color = 1;
    if (key == '2') Blocks[selected].Color = 2;
    if (key == '3') Blocks[selected].Color = 3;
    if (key == '4') Blocks[selected].Color = 4;
    if (key == CODED) {
      if (keyCode == UP) {
        if (selected > 0) selected -= 1;
      }
      if (keyCode == DOWN) {
        if (selected < 290) selected += 1;
      }
      if (keyCode == LEFT) {
        if (selected > 29) selected -= 29;
      }
      if (keyCode == RIGHT) {
        if (selected < 261) selected += 29;
      }
      for (int i =0; i < Blocks.length; i++) {
        Blocks[i].Selected = false;
      }
      Blocks[selected].Selected = true;
    }
  }

  set(0, 0, img);  // fast way to draw an image

  if (NOC >= 1) {
    for (int i = 0; i < NOC; i++) {
      fill(colors[i]);
      rect(300, 40+i*60 - 20, 40, 40);
    }
  } 

  for (Block b : Blocks) {
    b.draw();
  }
//if(triangle.contains(mouseX,mouseY)){

//  beginShape(TRIANGLE);
//  for(int i = 0 ; i < triangle.getVertexCount(); i++){
//    PVector v = triangle.getVertex(i);
//    vertex(v.x,v.y);
//  }
//  endShape(CLOSE);  


}


void keyReleased() {
  lock = false;
}