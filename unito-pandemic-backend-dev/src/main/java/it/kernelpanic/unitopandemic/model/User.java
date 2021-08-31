package it.kernelpanic.unitopandemic.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    private String email;
    private String password;
    private String pubKey;
    private Integer age;
    private Character gender;
    private Boolean infected;

    /*
     * Subjects that has more chance to spread the virus due to some peculiar genetic characteristic
     */
    private Boolean superSpreader;
}
