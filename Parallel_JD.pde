String path = "data.csv";
String CategoryName = "";
String[] MetricNames;
String[] CategoryValues;
String[] fullDataArray; 
double[][] values;
double[] axesMaxs;
double[] axesMins;
int[][] rowColor;
boolean[] flips;
boolean[] line_hover;



void loadStrings() {
  String[] fullData = loadStrings(path);
  String[] firstLine = split(fullData[0], ",");
  fullDataArray = new String[(fullData.length - 1) * firstLine.length];
  CategoryName = firstLine[0];
  MetricNames = new String[firstLine.length-1];
  for (int i = 1; i < firstLine.length; ++i) {
    MetricNames[i-1] = firstLine[i];
  } 
  for (int i = 1; i<fullData.length; i++){
  String[] temp = split(fullData[i],",");
   for(int j = 0; j < firstLine.length;j++){
      fullDataArray[j + (i-1)*firstLine.length] = temp[j];
   }
    
  }
  CategoryValues = new String[fullData.length-1];
  for (int i = 0; i< fullData.length-1; i++){
    CategoryValues[i] = fullDataArray[((i*(MetricNames.length+1)))];
  }
  
  values = new double[fullData.length-1][firstLine.length-1];
  for (int i = 1; i < fullData.length; i++) {
    String[] row = split(fullData[i], ",");
    for (int j = 1; j < firstLine.length; ++j) {
      values[i-1][j-1] = parseFloat(row[j]);
    }
      
    }
    
}

double getMin(double[][] array, int column){
  double tempMin = array[0][column]; 
  for(int i=0; i<array.length;i++){
    if (array[i][column]<tempMin){
    tempMin = array[i][column]; 

    }
  }
  
  return tempMin; 
}

double getMax(double[][] array, int column){
  double tempMax = array[0][column]; 
  for(int i=0; i<array.length;i++){
    if (array[i][column]>tempMax){
    tempMax = array[i][column]; 

    }
  }
  
  return tempMax; 
}

int[] getColumnVal(double[][] array, int index){
    int[] cVal = new int[array.length];
    for(int i=0; i < cVal.length; i++){
       cVal[i] = (int)array[i][index];
    }
    return cVal;
}



void drawAxes(){
    
    axesMaxs = new double[values[0].length];
    axesMins = new double[values[0].length];
    
    for (int i = 0; i<values[0].length;i++){
      axesMaxs[i] = getMax(values,i);
      axesMins[i] = getMin(values,i);
      fill(255,255,255);
      fill(255, 255, 255);
      textSize(height*width/60000);
      textAlign(CENTER, BOTTOM);
      
    }
  
  for (int i = 1; i<values[0].length+1;i++){
    stroke(255,255,255);
    fill(0,0,0);
    rectMode(CENTER);
    rect(width/(values[0].length+1)*i,height/2,width/120,2*height/3);
    fill(98,197,251);
    rect(width/(values[0].length+1)*i,height/1.1859,width/40,height/50);
    fill(255,0,0);
    textSize(width*height/80000);
    
    if(!flips[i-1]){text((int)(.9*axesMins[i-1]),width/(values[0].length+1)*i,height/1.175);}
    else{text((int)(1.1*axesMaxs[i-1]),width/(values[0].length+1)*i,height/1.175);}
    if(!flips[i-1]){text((int)(1.1*axesMaxs[i-1]),width/(values[0].length+1)*i,2*height/12);}
    else{text((int)(.9*axesMins[i-1]),width/(values[0].length+1)*i,2*height/12);}
    text(MetricNames[i-1],width/(values[0].length+1)*i,10.5*height/12);
     
  }
    //adds a title
    fill(0,0,0);
    textAlign(CENTER);
    String title = "Assingment 2 - Parallel Coordinates";
    textSize(width*height/50000);
    text(title,width/2,height/18);

}


void drawLines(){
     for (int k = 0; k<values[0].length;k++){
      axesMaxs[k] = getMax(values,k);
      axesMins[k] = getMin(values,k);
     }

  for (int i = 0; i<values.length;i++){
    stroke(rowColor[i][0],rowColor[i][1],rowColor[i][2]);
    if (line_hover[i]) {
      stroke(255,201,102);
    }
    for(int j = 0;j<values[i].length-1;j++){
      float xStart = (width/(values[0].length+1))*(j+1);
      float xEnd =  (width/(values[0].length+1)*(j+2));
      float yStart = parseFloat((int)(10*height/12 - ((((1.0)*values[i][j]/(axesMaxs[j]*1.1) * (8*height/12))))));
      float yEnd = parseFloat((int)(10*height/12 - (((1.0)*values[i][j+1]/(axesMaxs[j+1]*1.1) * (8*height/12)))));
      if(flips[j]){
        yStart = parseFloat((int)(2*height/12 + ((((1.0)*values[i][j]/(axesMaxs[j]*1.1) * (8*height/12))))));
      }
      if(flips[j+1]){
        yEnd = parseFloat((int)(2*height/12 + (((1.0)*values[i][j+1]/(axesMaxs[j+1]*1.1) * (8*height/12)))));
      }
      line(xStart,yStart,xEnd,yEnd);
    }

  }

  }
void checkHover(){
  for (int k = 0; k<values[0].length;k++){
      axesMaxs[k] = getMax(values,k);
      axesMins[k] = getMin(values,k);
     }
 for (int i = 0; i<values.length;i++){
    for(int j = 0;j<values[i].length-1;j++){
      float xStart = (width/(values[0].length+1))*(j+1);
      float xEnd =  (width/(values[0].length+1)*(j+2));
      float yStart = parseFloat((int)(10*height/12 - ((((1.0)*values[i][j]/(axesMaxs[j]*1.1) * (8*height/12))))));
      float yEnd = parseFloat((int)(10*height/12 - (((1.0)*values[i][j+1]/(axesMaxs[j+1]*1.1) * (8*height/12)))));
      if(flips[j]){
        yStart = parseFloat((int)(2*height/12 + ((((1.0)*values[i][j]/(axesMaxs[j]*1.1) * (8*height/12))))));
      }
      if(flips[j+1]){
        yEnd = parseFloat((int)(2*height/12 + (((1.0)*values[i][j+1]/(axesMaxs[j+1]*1.1) * (8*height/12)))));
      }    
     
     float lineEQ = yStart + xStart*((yEnd-yStart) /(xEnd - xStart));
     float mouseEQ = yStart + xStart*((mouseY-yStart)/(mouseX-xStart));
     int bound = height/50;
     if(lineEQ <= (mouseEQ + bound) && lineEQ >= (mouseEQ - bound) && mouseX >= xStart && mouseX<= xEnd){
       line_hover[i] = true;
       redraw();
      
     }
    }
 }
 }
void mouseMoved() {
  for (int i = 0; i < line_hover.length; ++i) {
    if (line_hover[i]) {
      line_hover[i] = false;
      redraw();
    }
  }
  checkHover();
}  
  
void mouseClicked(){
  
for (int k = 0; k<values[0].length;k++){
      axesMaxs[k] = getMax(values,k);
      axesMins[k] = getMin(values,k);
     }
for(int i = 1; i<values[0].length+1;i++){
   float xLeft = (width/(values[0].length+1)*i) - width/120;
   float xRight = (width/(values[0].length+1)*i) + width/120;
   float yBottom = 10*height/12; 
   float yTop = 2*height/12; 
   int[] cVal = getColumnVal(values,i-1);
   int columnMax = (int)axesMaxs[i-1];
   int columnMin = (int)axesMins[i-1];
   if (mouseX >= xLeft && mouseX <= xRight && mouseY >= yTop && mouseY <= yBottom) {
       for (int j = 0; j < rowColor.length; j++){
         if(flips[i-1]){
           rowColor[j][0] = (int)(255*(float)(cVal[j]-columnMax)/(columnMin-columnMax));
        }
        else {
          rowColor[j][0] = (int)(255*(float)(cVal[j]-columnMin)/(columnMax-columnMin));
        }
        rowColor[j][1] =  0;
        rowColor[j][2] = 255 - rowColor[j][0];
      }
       
      }
   float flipXlower = (width/(values[0].length+1)*i) - width/120;
   float flipxupper = (width/(values[0].length+1)*i) + width/120;
   float flipyBottom = height/1.175;
   float flipyTop = height/1.2;
  if(mouseX>= flipXlower && mouseX <= flipxupper && mouseY >=flipyTop && mouseY<= flipyBottom){
    flips[i-1]=!flips[i-1];
    redraw();
  }
}
 }




void setup() {
  size(1200, 800);
  frameRate(10);
  surface.setResizable(true);
  loadStrings();
    flips = new boolean[values[0].length];
  for (int i = 0; i < flips.length; ++i) {
    flips[i] = false;
  }
  line_hover = new boolean[values.length];
  for (int i = 0; i < line_hover.length; ++i) {
    line_hover[i] = false;
  }
    rowColor = new int[values.length][3];
  for (int j = 0; j < rowColor.length; ++j) {
    rowColor[j][0] = 42;
    rowColor[j][1] = 213;
    rowColor[j][2] = 247;
  }
}


void draw() {
  background(255, 255, 255);
  drawAxes();
  drawLines();
 
  }