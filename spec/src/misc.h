#ifndef MISC_H
#define MISC_H

/**
 *  \brief Represents a rectangle.
 *
 *  Struct representing a rectangle.
 */
struct Rect {
  /**
   *  X position
   */
  int x;
  /**
   *  Y position
   */
  int y;
  /**
   *  Width
   */
  int width;
  /**
   *  Height
   */
  int height;
};

/**
 *  \brief Create a Rect of 32x32 at origin.
 */
Rect * rect32();

/**
 *  \brief Create an empty Rect.
 */
static Rect * emptyRect();

/**
 *  \brief Directions.
 *
 *  Basic directions.
 */
enum Direction {
  /**
   *  \brief Up direction.
   *
   *  Direction represeting Up.
   */
  Up,
  Down,
  Left,
  Right
};

/**
 *  Pi constant
 */
float pi;

/**
 *  e constant
 */
static float e;

#endif // MISC_H