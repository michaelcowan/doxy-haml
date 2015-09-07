#ifndef ZOO_CAGE_H
#define ZOO_CAGE_H

#include "animal.h"

namespace zoo {

  /**
   *  \brief Represents a Cage at the zoo.
   *
   *  The class Cage contains an Animal at the zoo.
   *
   *  \author Michael Cowan
   */
  class Cage {

  public:

    /**
     *  \brief Sets the Animal.
     *
     *  Puts an Animal in this Cage.
     *
     *  \param [in] animal The Animal to put in this Cage.
     */
    void setAnimal(Animal * animal);

    /**
     *  \brief Gets the Animal.
     *
     *  Returns the Animal in this Cage.
     *
     *  \return the Animal in this Cage.
     */
    Animal * getAnimal() const;

  };
}

#endif // ZOO_CAGE_H