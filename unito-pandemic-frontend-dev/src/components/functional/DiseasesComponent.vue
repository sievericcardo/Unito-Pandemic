<template>
    <section class="box">
        <div class="columns">
            <div class="column">
                <h3 class="is-size-4 component-title">
                    <i class="fas fa-plus-square" /> New Disease
                </h3>
                <b-field label="Name">
                    <b-input v-model="newDiseaseName" placeholder="Name the disease"></b-input>
                </b-field>
                <b-field label="Probability">
                    <b-input type="number" v-model="newDiseaseProb" step=".01" placeholder="0,00"></b-input>
                </b-field>

                <div class="control">
                    <button class="button is-primary" @click="newDisease()">Submit</button>
                </div>
            </div>

            <div class="column">
                <h3 class="is-size-4 component-title">
                    <i class="fas fa-edit" /> Edit Disease
                </h3>
                <b-field label="Pick disease">
                    <b-select v-model="diseaseName" placeholder="Select a Disease">
                        <option
                            v-for="option in data"
                            :value="option.name"
                            :key="option.name"
                        >{{ option.name }}</option>
                    </b-select>
                </b-field>
                <b-field label="New probability">
                    <b-input v-model="diseaseProb" type="number" step=".01" placeholder="0,00"></b-input>
                </b-field>

                <div class="control">
                    <button class="button is-primary" @click="updateDisease()">Submit</button>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
const axios = require("axios").default;
import { SnackbarProgrammatic as Snackbar } from "buefy";

// For production
const url = "https://xelinion.servebeer.com:8443/unito-pandemic-rest-backend-1.0/";
// For dev
// const url = "http://localhost:8080/";

export default {
    name: "DiseasesComponent",
    data() {
        return {
            data: null,
            diseaseProb: 0,
            newDiseaseProb: 0,
            newDiseaseName: "",
            diseaseName: ""
        };
    },
    beforeCreate() {
        axios
            .get(url + "api/diseases/all", {
                headers: {
                    Authorization: "Bearer " + localStorage.getItem("jwt")
                }
            })
            .then(response => {
                this.data = response.data;
            })
            .catch(error => {
                Snackbar.open("Error " + error);
            });
    },
    methods: {
        newDisease() {
            const data = {
                contagion_probability: this.newDiseaseProb,
                name: this.newDiseaseName
            };
            const options = {
                headers: {
                    Authorization: "Bearer " + localStorage.getItem("jwt")
                }
            };
            axios
                .post(url + "api/diseases/new", data, options)
                .then(response => {
                    Snackbar.open(response.data.name + " created");
                })
                .catch(error => {
                    Snackbar.open("Not working: " + error);
                });
        },
        updateDisease() {
            const data = {
                contagion_probability: this.diseaseProb,
                name: this.diseaseName
            };
            const options = {
                headers: {
                    Authorization: "Bearer " + localStorage.getItem("jwt")
                }
            };
            axios
                .post(url + "api/diseases/update", data, options)
                .then(response => {
                    Snackbar.open(response.data.name + " updated");
                })
                .catch(error => {
                    Snackbar.open("Not working: " + error);
                });
        }
    }
};
</script>

<style scoped>
.fa,
.far,
.fas {
    font-family: "Font Awesome 5 Free" !important;
}
</style>
