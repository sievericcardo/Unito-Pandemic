package it.kernelpanic.unitopandemic.resolver;

import com.coxautodev.graphql.tools.GraphQLMutationResolver;
import it.kernelpanic.unitopandemic.model.*;
import it.kernelpanic.unitopandemic.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class Mutation implements GraphQLMutationResolver {

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

    public Mutation(ContagionRepository contagionRepository,
                    DetectionRepository detectionRepository,
                    DiseaseRepository diseaseRepository,
                    SimulationRepository simulationRepository,
                    UserRepository userRepository) {
        this.contagionRepository = contagionRepository;
        this.detectionRepository = detectionRepository;
        this.diseaseRepository = diseaseRepository;
        this.simulationRepository = simulationRepository;
        this.userRepository = userRepository;
    }

    public User newUser(String email, String password, String pubKey, int age,
                        char gender, boolean infected, boolean superSpreader) {
        User user = new User();
        user.setEmail(email);

        userRepository.save(user);

        return user;
    }

    public Disease newDisease(String name, float spreadProbability) {
        Disease disease = new Disease();

        disease.setName(name);
        disease.setSpreadProbability(spreadProbability);

        diseaseRepository.save(disease);

        return disease;
    }

    public Detection newDetection(double latitude, double longitude, float pressure,
                                  float altitude, long timestamp, User user) {
        Detection detection = new Detection();

        detection.setLatitude(latitude);
        detection.setLongitude(longitude);
        detection.setPressure(pressure);
        detection.setAltitude(altitude);
        detection.setTimestamp(timestamp);
        detection.setUser(user);

        detectionRepository.save(detection);

        return detection;
    }

    public Contagion newContagion(User infective, User victim) {
        Contagion contagion = new Contagion();

        contagion.setInfective(infective);
        contagion.setVictim(victim);

        contagionRepository.save(contagion);

        return contagion;
    }

    public Simulation newSimulation(long timestamp, int duration, Disease disease, User user) {
        Simulation simulation = new Simulation();

        simulation.setTimestamp(timestamp);
        simulation.setDuration(duration);
        simulation.setDisease(disease);
        simulation.setUser(user);

        simulationRepository.save(simulation);

        return simulation;
    }

    public Optional<User> updateUser(long id, String email, String password, String pubKey, int age,
                                     char gender, boolean infected, boolean superSpreader) {
        Optional<User> user = userRepository.findById(id);

        user.ifPresent(existingUser -> {
            existingUser.setEmail(email);
            existingUser.setPassword(password);
            existingUser.setPubKey(pubKey);
            existingUser.setAge(age);
            existingUser.setGender(gender);
            existingUser.setInfected(infected);
            existingUser.setSuperSpreader(superSpreader);
        });

        return user;
    }

    public Optional<Disease> updateDisease(long id, String name, float spreadProbability) {
        Optional<Disease> disease = diseaseRepository.findById(id);

        disease.ifPresent(existingDisease -> {
            existingDisease.setName(name);
            existingDisease.setSpreadProbability(spreadProbability);
        });

        return disease;
    }

    public Optional<Detection> updateDetection(long id, double latitude, double longitude, float pressure,
                                               float altitude, long timestamp, User user) {
        Optional<Detection> detection = detectionRepository.findById(id);

        detection.ifPresent(existingDetection -> {
            existingDetection.setLatitude(latitude);
            existingDetection.setLongitude(longitude);
            existingDetection.setPressure(pressure);
            existingDetection.setAltitude(altitude);
            existingDetection.setTimestamp(timestamp);
            existingDetection.setUser(user);
        });

        return detection;
    }

    public Optional<Contagion> updateContagion(long id, User infective, User victim) {
        Optional<Contagion> contagion = contagionRepository.findById(id);

        contagion.ifPresent(existingContagion -> {
            existingContagion.setInfective(infective);
            existingContagion.setVictim(victim);
        });

        return contagion;
    }

    public Optional<Simulation> updateSimulation(long id, long timestamp, int duration, Disease disease, User user) {
        Optional<Simulation> simulation = simulationRepository.findById(id);

        simulation.ifPresent(existingSimulation -> {
            existingSimulation.setTimestamp(timestamp);
            existingSimulation.setDuration(duration);
            existingSimulation.setDisease(disease);
            existingSimulation.setUser(user);
        });

        return simulation;
    }
}
