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

Rect * rect32();

static Rect * emptyRect();

#endif // MISC_H