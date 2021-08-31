package it.kernelpanic.unitopandemic.repository;

import it.kernelpanic.unitopandemic.model.Contagion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ContagionRepository extends JpaRepository<Contagion, Long> {
}
