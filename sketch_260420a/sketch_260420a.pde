float ballX = 60;//ボールｘ座標
float ballY = 300;//ボールｙ座標
float ballDegree = 0;//ボールの角度
float ballSpeed = 3;//ボールの速さ
int paddleR = 300;//右パドルのｙ座標
int paddleL = 300;//左パドルのｙ座標
int futosa = 10;//点数表示の大きさ（なくてもいい）
int scoreR = 0;//右プレイヤーの得点
int scoreL = 0;//左プレイヤーの得点
int hh = 0;//点数表示に使うなんかよくわかんない変数　ぶっちゃけ消したかった
Boolean battle = false;//試合中かどうか判別するやつ
Boolean lu = false;//キーを押してるかどうかの状態を判別するやつ
Boolean ld = false;//キーを押してるかどうか以下略
Boolean ru = false;//キーを以下略
Boolean rd = false;//略

void digit(Boolean aa,Boolean bb,Boolean cc,Boolean dd,Boolean ee,Boolean ff,Boolean gg){
if(aa) line(hh - futosa * 2,300 - futosa * 4,hh + futosa * 2,300 - futosa * 4);
if(bb) line(hh - futosa * 2,300 - futosa * 4,hh - futosa * 2,300);
if(cc) line(hh + futosa * 2,300 - futosa * 4,hh + futosa * 2,300);
if(dd) line(hh - futosa * 2,300,hh + futosa * 2,300);
if(ee) line(hh - futosa * 2,300,hh - futosa * 2,300 + futosa * 4);
if(ff) line(hh + futosa * 2,300,hh + futosa * 2,300 + futosa * 4);
if(gg) line(hh - futosa * 2,300 + futosa * 4,hh + futosa * 2,300 + futosa * 4);
}//デジタル感あふれる感じの点数表示を作る基礎部分

void score(int suuzi,int xx){//suuziには表示する数字、xxには中心のｘ座標、yyには中心のｙ座標を入れる
    hh = xx;
    if(suuzi == 0) digit(true,true,true,false,true,true,true);
    if(suuzi == 1) digit(false,false,true,false,false,true,false);
    if(suuzi == 2) digit(true,false,true,true,true,false,true);
    if(suuzi == 3) digit(true,false,true,true,false,true,true);
    if(suuzi == 4) digit(false,true,true,true,false,true,false);
    if(suuzi == 5) digit(true,true,false,true,false,true,true);
    if(suuzi == 6) digit(true,true,false,true,true,true,true);
    if(suuzi == 7) digit(true,true,true,false,false,true,false);
    if(suuzi == 8) digit(true,true,true,true,true,true,true);
    if(suuzi == 9) digit(true,true,true,true,false,true,true);
}//digit関数を使って数字をもうちょっと楽にデジタルっぽくできるようにしてるやつ

void keyPressed(){
    if(key == 'w')      lu = true;//キーが押されたときパドルが動き始める
    if(key == 's')      ld = true;
    if(keyCode == UP)   ru = true;
    if(keyCode == DOWN) rd = true;
    if(key == 'r' && !battle){//点が入った後のリスタート用
        if((scoreR + scoreL) % 2 == 1){
            ballX = 740;
            ballDegree = random(30) + 210;
        }else{
            ballX = 60;
            ballDegree = random(30) + 300;
        }
        ballY = 300;
        paddleR = 300;
        paddleL = 300;
        ballSpeed = 3;
        battle = true;
        loop();
    }
}
void keyReleased(){
    if(key == 'w')      lu = false;//キーが押されなくなったときパドルが止まる
    if(key == 's')      ld = false;
    if(keyCode == UP)   ru = false;
    if(keyCode == DOWN) rd = false;
}
//上二つでキー入力を判別するとキーの同時押しとかができるようになる…らしい
 
void setup(){//せっとあっぷ
    size(800,600);
    strokeWeight(10);
    strokeCap(PROJECT);
    stroke(255);
    println("w");
    noLoop();
}

void draw(){
    background(0);
    if(lu){//パドルを実際に動かす部分ーーーーーーーーーーーーーーーーーーーーーーー
        paddleL = constrain(paddleL - 2,55,545);
    }
    if(ld){
        paddleL = constrain(paddleL + 2,55,545);
    }
    if(ru){
        paddleR = constrain(paddleR - 2,55,545);
    }
    if(rd){
        paddleR = constrain(paddleR + 2,55,545);
    }
    line(50,paddleL + 50,50,paddleL - 50);
    line(750,paddleR + 50,750,paddleR - 50);
    //ボールの移動ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    ballSpeed = ballSpeed + 0.005;
    ballX = ballX + ballSpeed * cos(radians(ballDegree));
    ballY = ballY + ballSpeed * sin(radians(ballDegree));
    //ボールの反射と打ち返せなかった時の処理ーーーーーーーーーーーーーーーーーーーー
    if(ballY < 5 || ballY > 595){
        ballDegree = 0 - ballDegree;
    }
    if(ballX < 60){
        if((abs(paddleL - ballY)) <= 60){
            ballDegree = 180 - ballDegree;
        } else{
            scoreR = scoreR + 1;
            strokeWeight(futosa);
            score(scoreR % 10,580);
            score((scoreR - (scoreR % 10)) / 10,500);
            score(scoreL % 10,300);
            score((scoreL - (scoreL % 10)) / 10,220);
            line(370,300,430,300);
            battle = false;
            noLoop();
        }
            
    }
    if(ballX > 740){
        if((abs(paddleR - ballY)) <= 60){
            ballDegree = 180 - ballDegree;
        } else{
            scoreL = scoreL + 1;
            strokeWeight(futosa);
            score(scoreR % 10,580);
            score((scoreR - (scoreR % 10)) / 10,500);
            score(scoreL % 10,300);
            score((scoreL - (scoreL % 10)) / 10,220);
            line(370,300,430,300);
            battle = false;
            noLoop();
        }
    }//この上二つめっちゃ似たようなコードだからまとめれそうなんだけどどうすればよかったのだろうか
    point(ballX,ballY);
}
