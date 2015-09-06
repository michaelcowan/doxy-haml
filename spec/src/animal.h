/**
 *  \brief Represents an Animal in the zoo.
 *
 *  The class Animal contains information and functions related to all animals in the zoo.
 *
 *  \author Michael Cowan
 */

 #ifndef ZOO_ANIMAL_H
 #define ZOO_ANIMAL_H

namespace zoo {
  class Animal {

  public:
    
    enum Kind {
      Mammal,
      Bird,
      Fish,
      Reptile,
      Amphibian
    };

    /**
     *  \brief Animal Constructor.
     *
     *  Constructs an Animal.
     *
     *  \param [in] kind The Kind of Animal being constructed.
     */
    virtual Animal(Kind kind);

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

  };
}

#endif // ZOO_ANIMAL_H