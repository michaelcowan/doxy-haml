#ifndef ZOO_CAGE_H
#define ZOO_CAGE_H

#include "animal.h"

/**
 *  \brief Zoo interfaces and implementations.
 *
 *  The zoo namespace holds all interfaces and implementations related to the zoo.
 *  This includes Animal, Cage and Monkey.
 *
 *  \author Michael Cowan
 */
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

    class Bar {

    };

    /**
     *  \brief Sets the Animal.
     *
     *  \param animal The Animal to put in this Cage.
     *  \param mate An optional mate for the Animal.
     *  \return true if the Animal can be put in this cage.
     */
    bool setAnimal(Animal * animal, Animal * mate = NULL);

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
     *  \param [in] hasRoof Set to true if the cage has a roof.
     */
    void setDimensions(int width, int height, bool hasRoof);

  };
}

#endif // ZOO_CAGE_H