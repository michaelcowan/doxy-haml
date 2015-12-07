#ifndef ZOO_ANIMAL_H
#define ZOO_ANIMAL_H

#include "organism.h"

namespace zoo {

  /**
   *  \brief Represents an Animal in the zoo.
   *
   *  The class Animal contains information and functions related to all animals in the zoo.
   *
   *  \author Michael Cowan
   */
  class Animal : public Organism {

  public:
    
    /**
     *  \brief Kinds of vertebrate Animal.
     *
     *  The most common types of vertebrate Animal kept at the zoo.
     */
    enum Kind {
      /**
       *  \brief Mammal Animal.
       *
       *  Mammal is a Kind of Animal in the zoo.
       */
      Mammal, 
      Bird,
      Fish,
      Reptile,
      Amphibian
    };

    /**
     *  \brief Animal default Constructor.
     *
     *  Constructs a default Mammal Animal.
     */
    Animal();

    /**
     *  \brief Animal Constructor.
     *
     *  Constructs an Animal.
     *
     *  \param [in] kind The Kind of Animal being constructed.
     */
    Animal(Kind kind);

    /**
     *  \brief Animal Destructor.
     *
     *  Destructs an Animal.
     */
    virtual ~Animal();

    /**
     *  \brief Get the leg count of this Animal.
     *
     *  Returns how many legs this Animal has.
     *
     *  \return the number of legs for this Animal.
     */
    virtual int getNumberOfLegs() const = 0;

    /**
     *  \brief Can this Animal fly?
     *
     *  Returns true if an Animal of this Kind can fly.
     *
     *  \return true if this Animal can fly.
     */
    bool canFly() const;

    CagePath * getPathFrom(Cage * cage, bool);

    /**
     *  \brief Feed the Animal.
     *
     *  Feeds the Animal. The volume is specific to each Animal Kind.
     *
     *  This does not mean the Animal is eating.
     *
     *  \param [in] volume The number of portions to feed the Animal.
     */
    virtual void feed(const int volume) = 0;

    void _kill();

  };
}

#endif // ZOO_ANIMAL_H