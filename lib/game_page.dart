import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const String PLAYER_X='X';
  static const String PLAYER_Y='O';

  late String currentPlayer;
  late bool gameEnd;
  late List<String> occupied;

  @override
  void initState() {
    initializeGame();
    // TODO: implement initState
    super.initState();
  }

  void initializeGame(){
  currentPlayer=PLAYER_X;
  gameEnd=false;
  occupied=["","","","","","","","",""];//9 empty places
  }


  @override
  Widget build(BuildContext context) {
return Scaffold(
  body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _headerText(),
        _gameContainer(),
        _restartButton(),
      ],
    ),
  ),
);
  }
  Widget _headerText(){
    return Column(
      children: [
        const Text("Tic Tac Toe",style: TextStyle(
          color: Colors.blue,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),),
        Text("$currentPlayer turn",
          style: const TextStyle(
          color: Colors.green,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),

        ),

      ],
    );
  }
  Widget _gameContainer(){
    return Container(
      height: MediaQuery.of(context).size.height/2,
      width: MediaQuery.of(context).size.height/2,
    margin: const EdgeInsets.all(8),
      child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: (context,int index){
        return _box(index);
      }),
    );
  }
  Widget _box(int index){
    return InkWell(
      onTap: (){
        //on click of box
        if (gameEnd||occupied[index].isNotEmpty){
          //the box emlemnt is not change
          return;
        }
        setState(() {
          occupied[index]=currentPlayer;
          changeTurn();
          checkForWinner();
          checkForDraw();
        });
      },
      child: Container(
        color: occupied[index].isEmpty?Colors.blueGrey:
        occupied[index]==PLAYER_X?Colors.amber:Colors.cyan,
        margin: const EdgeInsets.all(5),
        child: Center(child:
        Text(
            occupied[index],
        style: const TextStyle(fontSize: 50)
        ),
        ),
      ),
    );
  }
  _restartButton(){
    return ElevatedButton(onPressed: (){
setState(() {

  initializeGame();
});
    }, child: const Text("Restart Game"));
  }
  changeTurn(){
    if(currentPlayer==PLAYER_X){
      currentPlayer=PLAYER_Y;
    }else{
      currentPlayer=PLAYER_X;
    }
  }checkForWinner() {
    List<List<int>>winningList=[
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6],
    ];
  for(var winningPos in winningList){
    String playerPostion0=occupied[winningPos[0]];
    String playerPostion1=occupied[winningPos[1]];
    String playerPostion2=occupied[winningPos[2]];
    if(playerPostion0.isNotEmpty){
      if(playerPostion0==playerPostion1 && playerPostion0==playerPostion2){
        showGameOverMassage("Player $playerPostion0 won");
        gameEnd=true;
        return;
      }
    }
  }
  }
  checkForDraw(){
    if(gameEnd){
      return;
    }
    bool draw=true;
    for(var occupiedPlayer in occupied){
      if(occupiedPlayer.isEmpty){
        //at least one is empty not all are filled
        draw=false;
      }
    }
    if(draw){
      showGameOverMassage("Draw");
      gameEnd=true;
    }
  }

  showGameOverMassage(String message){
   ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("Game over\n $message",textAlign:TextAlign.center,style: const TextStyle(fontSize: 20,),)),
   );
  }
}

