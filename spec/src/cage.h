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
     *  \param [in] mate An optional mate for the Animal.
     */
    void setAnimal(Animal * animal, Animal * mate = NULL);

    /**
     *  \brief Gets the Animal.
     *
     *  Returns the Animal in this Cage.
     *
     *  \return the Animal in this Cage.
     */
    Animal * getAnimal() const;

    /**
     *  \brief Sets the Cage dimensions.
     *
     *  Sets the dimensions of the Cage for the Animal.
     *
     *  \param [in] width The width of the cage.
     *  \param [in] height The height of the cage.
     */
    void setDimensions(int width, int height);

  };
}

#endif // ZOO_CAGE_H