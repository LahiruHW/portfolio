import 'dart:math';

class RandomNums{

  static Random randGen = new Random();

  static int getRandInt(int? min, int max){
    min = (min == null) ? (0) : (min);
    return randGen.nextInt(max - min) + min;
  }

  static double getRandDouble(double min, double max){
    min = (min == null) ? (0.0) : (min);
    return randGen.nextDouble() * ( min + (max-min) );
  }

}
