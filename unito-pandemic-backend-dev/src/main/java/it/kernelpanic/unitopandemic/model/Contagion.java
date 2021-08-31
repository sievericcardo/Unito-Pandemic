package it.kernelpanic.unitopandemic.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class Contagion {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_infective", nullable = false)
    private User infective;

    @ManyToOne
    @JoinColumn(name = "user_victim", nullable = false)
    private User victim;
}
