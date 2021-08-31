package it.kernelpanic.unitopandemic.repository;

import it.kernelpanic.unitopandemic.model.Simulation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SimulationRepository extends JpaRepository<Simulation, Long> {
}
