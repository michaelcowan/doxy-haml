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

#endif // MISC_H