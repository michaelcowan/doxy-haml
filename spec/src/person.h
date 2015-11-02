#ifndef PERSON_H
#define PERSON_H

namespace bob {
  namespace robert {
    namespace william {

    }
  }
}

/**
 *  \brief Represents a Person.
 *
 *  The class Person contains information and functions related to all people
 *
 *  \author Michael Cowan
 */
class Person {

public:

  /**
   *  \brief Sets name.
   *
   *  Sets the name of the Person.
   *
   *  \param [in] name The name of the Person
   */
  void setName(const char * name);

  /**
   *  \brief Sets name.
   *
   *  Sets both names of the Person.
   *
   *  \param [in] firstname The first name of the Person
   *  \param [in] secondname The second name of the Person
   */
  void setName(const char * firstname, const char * secondname);

};

#endif // PERSON_H