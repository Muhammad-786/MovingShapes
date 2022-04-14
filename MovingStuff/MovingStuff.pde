class Entity{
  float x;
  float y;
  float destx;
  float desty;
  float speed;
  float movingAngle;
  boolean selected;
  boolean moving;
  public Entity(){
    x = random(width);
    y = random(height);
    speed = 5;
    selected = moving = false;
  }
  public void tick(){
    if(moving){
      x += cos(movingAngle)*speed;
      y += sin(movingAngle)*speed;
      if(sqrt(sq(destx-x)+sq(desty-y)) <= speed){
        moving = false;
      }
    }
    if(selected){
      stroke(255);
      fill(255,0,0);
    }
    else{
      stroke(0);
      fill(0,100,200);
    } 
    rect(x,y,50,50);
  }
  public void goTo(float dx,float dy){
    destx = dx;
    desty = dy;
    movingAngle = atan2(dy-y,dx-x);
    moving = true;
  }
}
ArrayList entities;
void setup(){
  size(800,800);
  smooth();
  background(128);
  entities = new ArrayList();
  for(int i = 0; i< 50;i++){
    entities.add(new Entity());
  }
}
void draw(){
  background(0);
  for(int i = 0; i< entities.size();i++){
    Entity e = (Entity)entities.get(i);
    e.tick();
  }
}
void mousePressed(){
  //If no entity was pressed then we want them to move wherever the user clicked
  boolean entityPressed = false;
  //loop in reverse order so that if two square are on top of each other the one on top is selected
  for(int i = entities.size()-1; i>= 0 ;i--){
    Entity e = (Entity)entities.get(i);
    if(mouseX > e.x && mouseX < e.x+50 &&mouseY > e.y && mouseY < e.y+50){
      entityPressed = true;
      if(e.selected){
        e.selected = false;
      }
      else{
        e.selected = true;
      }
      break;//break so that no ther square are selected, this can be removed
    }
  }
  //No entity was pressed - move all selected entities to where the user clicked and unselect them.
  if(!entityPressed){
    for(int i = 0; i< entities.size();i++){
      Entity e = (Entity)entities.get(i);
      if(e.selected){
        e.goTo(mouseX+random(-50,50),mouseY+random(-50,50));
        e.selected = false;
      }
    }
  }
}
