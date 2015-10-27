#ifndef ZOO_CAGEPATH_H
#define ZOO_CAGEPATH_H

namespace zoo {

  class Cage;

  /**
   *  \brief Represents a path between Cage instances.
   *
   *  The struct CagePath is used to create paths between instances of Cage.
   *
   *  \author Michael Cowan
   */
  struct CagePath {
    /**
     *  \brief Current Cage.
     *
     *  Cage to start path from.
     */
    Cage * current;
    /**
     *  \brief Next Cage.
     *
     *  Cage where the path ends.
     */
    Cage * next;
    /**
     *  \brief Distance.
     *
     *  Distance between the two Cage instances.
     */
    int distance;
    /**
     *  \brief First CagePath instance.
     *
     *  The first CagePath instance.
     */
    static Cage * first;
  };

  CagePath * emptyCagePath();

}

#endif // ZOO_CAGEPATH_H
