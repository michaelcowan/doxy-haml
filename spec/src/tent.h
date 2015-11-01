#ifndef ZOO_EXHIBIT_TENT_H
#define ZOO_EXHIBIT_TENT_H

#include "animal.h"

namespace zoo {

  /**
   *  \brief Exhibit interfaces and implementations.
   *
   *  The exhibit namespace holds all interfaces and implementations related to exhibits at the zoo.
   */
  namespace exhibit {

    /**
     *  \brief State of exhibits.
     *
     *  Exhibit state.
     */
    enum State {
      /**
       *  \brief Open exhibit.
       *
       *  Exhibit is Open.
       */
      Open,
      Closed
    };

    static int maxExhibits;

    int minExhibits;

    /**
     *  \brief Represents a Tent at the zoo.
     *
     *  The class Tent represents a concrete exhibit at the zoo.
     *
     *  \author Michael Cowan
     */
    class Tent {

    };
  }

}

#endif // ZOO_EXHIBIT_TENT_H