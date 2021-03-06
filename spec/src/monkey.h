#ifndef ZOO_MONKEY_H
#define ZOO_MONKEY_H

#include "animal.h"

namespace zoo {

  /**
   *  \brief Represents a Monkey in the zoo.
   *
   *  The class Monkey extends Animal with specifics about monkeys in the zoo.
   *
   *  \author Michael Cowan
   */
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
     *  \brief Feed the Monkey.
     *
     *  Feeds the Monkey.
     *
     *  \param [in] volume The number of portions to feed the Monkey.
     */
    virtual void feed(const int volume);

    /**
     *  \brief Get the Monkey count.
     *
     *  Returns the Monkey count for the entire zoo.
     *
     *  \return the Monkey count for the zoo.
     */
    static int numberOfMonkeys() const;

    /**
     *  \brief Indicates if the Monkey can see.
     *
     *  Returns true if the Monkey can see, else false.
     *
     *  \return True if the Monkey can see.
     */
    virtual bool canSee();

  };
}

#endif // ZOO_MONKEY_H