import 'dart:math';

class RandomNums{

  static Random randGen = new Random();

  int getRandInt(int? min, int max){
    min = (min == null) ? (0) : (min);
    return randGen.nextInt(max - min) + min;
  }

  double getRandDouble(double min, double max){
    return ( randGen.nextDouble() * min ) + (max-min);
  }

}
