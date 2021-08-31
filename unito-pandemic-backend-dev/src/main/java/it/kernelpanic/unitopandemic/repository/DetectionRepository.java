package it.kernelpanic.unitopandemic.repository;

import it.kernelpanic.unitopandemic.model.Detection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DetectionRepository extends JpaRepository<Detection, Long> {
}
