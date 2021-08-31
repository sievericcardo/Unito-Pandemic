package it.kernelpanic.unitopandemic.resolver;

import com.coxautodev.graphql.tools.GraphQLQueryResolver;
import it.kernelpanic.unitopandemic.model.*;
import it.kernelpanic.unitopandemic.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class Query implements GraphQLQueryResolver {

    @Autowired
    private ContagionRepository contagionRepository;

    @Autowired
    private DetectionRepository detectionRepository;

    @Autowired
    private DiseaseRepository diseaseRepository;

    @Autowired
    private SimulationRepository simulationRepository;

    @Autowired
    private UserRepository userRepository;

    public Optional<Contagion> contagion(Long id) {
        return contagionRepository.findById(id);
    }

    public Optional<Detection> detection(Long id) {
        return detectionRepository.findById(id);
    }

    public Optional<Disease> disease(Long id) {
        return diseaseRepository.findById(id);
    }

    public Optional<Simulation> simulation(Long id) {
        return simulationRepository.findById(id);
    }

    public Optional<User> user(Long id) {
        return userRepository.findById(id);
    }

    public Iterable<Contagion> findAllContagion() {
        return contagionRepository.findAll();
    }

    public Iterable<Detection> findAllDetection() {
        return detectionRepository.findAll();
    }

    public Iterable<Disease> findAllDisease() {
        return diseaseRepository.findAll();
    }

    public Iterable<Simulation> findAllSimulation() {
        return simulationRepository.findAll();
    }

    public Iterable<User> findAllUser() {
        return userRepository.findAll();
    }
}
