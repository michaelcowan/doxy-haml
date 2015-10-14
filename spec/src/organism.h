#ifndef ZOO_ORGANISM_H
#define ZOO_ORGANISM_H

namespace zoo {

  /**
   *  \brief Represents an Organism in the zoo.
   *
   *  The class Organism contains information and functions related to all organisms in the zoo.
   *
   *  \author Michael Cowan
   */
  class Organism {

  public:

    /**
     *  \brief Indicates if the Organism can see.
     *
     *  Returns true if the Organism can see, else false.
     *
     *  \return True if the Organism can see.
     */
    virtual bool canSee() = 0;

  };

}

#endif // ZOO_ORGANISM_H