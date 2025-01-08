// Dependancy C++ header files 
#include <iostream>
#include <vector>
#include <random>
#include <sstream>



class Person {
//instance variables
    int infectionDays;
    std::string current;
//constructors(default)
    public:
        Person() {
            current = "susceptible";
            infectionDays = 0;
        }
// updates current state of a person 
    void currentState() {
        if (current == "sick") {
            infectionDays--;
            current = (infectionDays == 0) ? "recovered" : current;
        }
    }

// infect person for nth days
    void infect(int duration) {
        if (current == "susceptible") {
            infectionDays = duration;
            current = "sick";
        }
    }

// Check on recovery and infections
    bool isStable() {
        return current == "recovered";
    }

    bool isInfected() {
        return current == "sick";
    }

// function to return the current status 
    std::string getStatus() {
        return current;
    }

};

// Population class 
class Population {

    public:
    // field variables
    int day;         // number of simulation days 
    int size;        // size of a population

    // All compartment counts 
    int countInfected;    
    int countSusceptible;
    int countRecoverred;
    // Key parameters of simulation i.e. probability of infection on contact, number contact per infection, total infection days
    float probability;
    int contacts;
    int infectionDays; 
    //
    std::vector < Person * > Pop;

    public:
        // Constructor
        Population(int sizeofPopulation) {

            size = sizeofPopulation;
            day = 0;

            countInfected = 0;
            countSusceptible = sizeofPopulation;
            countRecoverred = 0;


            probability = 0.0;
            contacts = 0;
            infectionDays = 0;
            //construct initial population of default persons
            for (int i = 0; i < sizeofPopulation; i++) {
                Pop.push_back(new Person());
            }
    
        }


    //Infect a random person in a population
    void infectRandomPersons() {
        countInfected = 1;
        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_int_distribution < > dis(0, size - 1);
        int index = dis(gen);
        Person * choosen = Pop[index];
        thePersonToinfect(choosen);
    }

    // Gives current state of the persons in population
    void currentState() {
        int theinfectcount = 0;
        int theSusceptibleCount = 0;
        int theRecoveredCount= 0;
        std::vector <Person*> newly_infected;

        for (int i = 0; i < Pop.size(); ++i) {
            Person * person = Pop.at(i);
            if (person -> getStatus() == "sick") {
                theinfectcount++;
                contract(newly_infected);
            } else if (person -> getStatus() == "susceptible") {
                theSusceptibleCount++;
            } else if (person -> getStatus() == "recovered") {
                theRecoveredCount++;
            }  else {
                
            }

           
            person -> currentState();
        }

        day++;
        countInfected = theinfectcount;
        countSusceptible = theSusceptibleCount;
        countRecoverred = theRecoveredCount;
        for (Person * person: newly_infected) {
            thePersonToinfect(person);
        }

    }

     // Sets amount probability of contraction
    void contractProbability(float probability) {
        this -> probability = probability;
    }


    //sets  number of contact
    void setContactCount(int contacts) {
        this -> contacts = contacts;
    }


    // set sick days
    void setSickDays(int infectionDays) {
        this -> infectionDays = infectionDays;
    }
    
    // infect the assigned person
    void thePersonToinfect(Person * person) {
        person -> infect(infectionDays);
    }


    // function that will contract another suceptible person based upon certain probability
    void contract(std::vector<Person*>& newly_infected) {
    std::mt19937 gen(std::random_device{}());
    std::uniform_int_distribution<> dis(0, Pop.size() - 1);
    for (int i = 0; i < std::min(contacts, static_cast<int>(Pop.size()) - 1); ++i) {
        if (static_cast<float>(gen()) / gen.max() <= probability) {
            newly_infected.push_back(Pop[dis(gen)]);
        }
    }
}


};


int main() {

    int population_size = 1000;
    int initial_infections = 5;
    int days_to_simulate = 90;

    // Initiate a population
    Population population(population_size);

    // Set the key parameters 
    population.setContactCount(6);
    population.setSickDays(5);
    population.contractProbability(0.5);

    // Fix number of random person infection
    for (int i = 0; i < initial_infections; i++) {
        population.infectRandomPersons();
    }

    // Run simulation for specified number of days
    for (int day = 1; day <= days_to_simulate; day++) {

        // currentState population current
        population.currentState();

        // Output infectionDays day and population current
        //std::cout << "Day " << day << ": " << population.status_of_people() << std::endl;
        //std::cout <<population.countInfected<<std::endl;
        std::cout << std::endl;
        std::cout << "Days, " << "Susciptible," << " Recovered," << "Infected,   " << day << "," << population.countSusceptible << "," << population.countRecoverred << "," << population.countInfected << std::endl;

    }

    return 0;
}