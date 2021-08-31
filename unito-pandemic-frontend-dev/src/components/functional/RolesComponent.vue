<template>
    <section class="box">
        <div class="columns">
            <div class="column is-two-fifth">
                <h3 class="is-size-4 component-title">
                    <i class="fas fa-user-tag" /> Set a new role
                </h3>
                <b-field label="Email">
                    <b-select placeholder="Select a user" v-model="userEmail">
                        <option
                            v-for="option in data"
                            :value="option.email"
                            :key="option.email"
                        >{{ option.email }}</option>
                    </b-select>
                </b-field>

                <b-field label="Role">
                    <b-select placeholder="Set a role" v-model="userRole">
                        <option value="ADMIN">Admin</option>
                        <option value="RESEARCHER">Researcher</option>
                    </b-select>
                </b-field>

                <div class="control">
                    <button class="button is-primary" @click="updateRoles()">Submit</button>
                </div>
            </div>
            <div class="column">
                <!-- Insert dataviz for roles -->
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
    name: "RolesComponent",
    data() {
        return {
            data: null,
            userRole: "",
            userEmail: ""
        };
    },
    beforeCreate() {
        axios
            .get(url + "api/backofficeuser/all", {
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
        updateRoles() {
            const data = {
                email: this.userEmail,
                roles: [this.userRole]
            };
            const options = {
                headers: {
                    Authorization: "Bearer " + localStorage.getItem("jwt")
                }
            };
            axios
                .post(url + "api/backofficeuser/add/role", data, options)
                .then(response => {
                    Snackbar.open("Updated role for " + response.data.email);
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