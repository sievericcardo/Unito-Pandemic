<template>
    <section class="box">
        <h1 class="is-size-4">
            <i class="fas fa-syringe"></i> New Contagion:
        </h1>
        <br />
        <b-field label="Affected Public Key">
            <!-- <b-select placeholder="Select a subject">
                <option
                    v-for="option in key"
                    :value="option.pub_key"
                    :key="option.pub_key"
                >{{ option.pub_key }}</option>
            </b-select> -->
            <b-input v-model="pubKey" placeholder="Public key"></b-input>
        </b-field>

        <b-field label="Disease">
            <b-select placeholder="Select a user" v-model="diseaseName">
                <option
                    v-for="option in disease"
                    :value="option.name"
                    :key="option.name"
                >{{ option.name }}</option>
            </b-select>
        </b-field>

        <b-field label="Test date">
            <b-datepicker placeholder="Click to select..." icon="calendar-today" trap-focus></b-datepicker>
        </b-field>

        <b-field label="Test Outcome">
            <b-switch 
                v-model="isSwitched"
                true-value="Positive"
                false-value="Negative"
            >{{ isSwitched }}</b-switch>
        </b-field>

        <div class="control">
            <button class="button is-primary" @click="addContagion()">Submit</button>
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
    name: "NewTestOutcomeComponent",
    data: function() {
        return {
            isSwitched: "Positive",
            disease: null,
            key: null,
            pubKey: "",
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
                this.disease = response.data;
            })
            .catch(error => {
                Snackbar.open("Error " + error);
            });
        axios
            .get(url + "api/contagion/all", {
                headers: {
                    Authorization: "Bearer " + localStorage.getItem("jwt")
                }
            })
            .then(response => {
                this.key = response.data;
            })
            .catch(error => {
                Snackbar.open("Error " + error);
            });
    },
    methods: {
        addContagion() {
            const data = {
                pubKey: this.pubKey,
                name: this.diseaseName
            };
            const options = {
                headers: {
                    Authorization: "Bearer " + localStorage.getItem("jwt")
                }
            };
            axios
                .post(url + "api/realcontagions/user/" + 
                    this.pubKey + "/disease/" + this.diseaseName + "/new", 
                    data, options)
                .then(response => {
                    Snackbar.open("Contagion for " + 
                        response.data.disease.name + " added to user");
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
