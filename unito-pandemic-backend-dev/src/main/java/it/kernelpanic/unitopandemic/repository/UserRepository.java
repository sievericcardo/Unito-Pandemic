package it.kernelpanic.unitopandemic.repository;

import it.kernelpanic.unitopandemic.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
}
