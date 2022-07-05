// import 'dart:collection';

// import 'package:flappy_bird/barriers.dart';

// TODO: Create a full dart QUEUE implementation for creating/adding/deleting Barrier2 widgets
//       (MUST NOT OPERATE ON MAIN UI THREAD) on either end. // tutorial: https://www.youtube.com/watch?v=2rXw0aVijOI
// EDIT: Changed "Linked List" to "Queue" because there is no point in maintaining pointers for 
//       elements that are going to be detroyed

// class BarrierQueue{

//     static final Queue< List<Barrier> > queue = new Queue();
//     static final Queue< double > bQueue = new Queue();
        
//         // start by generating random height values
//         // inflate these values into their own barrier objects, then add them to the respective queue!


//     /// add new barriers, starting from the front
//     /// can use bQueue.add() or bQueue.addLast(), it doesn't matter
//     static void add(width, height, isDownBarrier, xCoord){

//         Barrier new_barrier = Barrier(isDownBarrier: ,);

//         bQueue.addLast(value)
//     }

//     /// serve current head barrier
//     static void removeFrontBarrier(){
//         bool answer = isBarrierVisible(0); // check if the current front barrier has exited the screen.
//         if (answer && bQueue.length != 0) {     // If so, remove it from the queue
//             bQueue.removeFirst();
//         }
//     }


//     // check if the current front barrier has exited the screen from the left
//     static bool isBarrierVisible(int index){
        
//         List<Barrier> this_barrier = bQueue.elementAt(index) as List<Barrier>;
        
//         return false;
//     }

// }












