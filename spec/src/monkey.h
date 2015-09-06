/**
 *  \brief Represents a Monkey in the zoo.
 *
 *  The class Monkey extends Animal with specifics about monkeys in the zoo.
 *
 *  \author Michael Cowan
 */

 #ifndef ZOO_MONKEY_H
 #define ZOO_MONKEY_H

 #include "animal.h"

namespace zoo {
  class Monkey : public Animal {

  public:

    /**
     *  \brief Get the leg count of a Monkey.
     *
     *  Returns how many legs a Monkey has.
     *
     *  \return the number of legs for a Monkey.
     */
    virtual int getNumberOfLegs() const;

    /**
     *  \brief Get the Monkey count.
     *
     *  Returns the Monkey count for the entire zoo.
     *
     *  \return the Monkey count for the zoo.
     */
    static int numberOfMonkeys() const;

  };
}

#endif // ZOO_MONKEY_H