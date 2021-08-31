<template>
    <div>
        <TheNavbar />
        <div class="container-fluid h-100 d-inline-block">
            <div class="columns is-gapless is-desktop is-vcentered is-padded">
                <div class="column">
                    <article class="message is-info">
                        <div class="message-header">
                            Info
                            <button class="delete"></button>
                        </div>
                        <div class="message-body">
                            UniTO pandemic è un'applicazione molto semplice nata con lo scopo di aiutare la comunità scientifica a sviluppare modelli di predizione di un contagio virale, evitando la condivisione dei dati di geolocalizzazione degli utenti.
                        </div>
                    </article>
                    <img src="@/assets/images/unito.png" />
                </div>
                <div class="column">
                    <section class="login-form is-padded">
                        <b-field label="Email">
                            <b-input type="email" v-model="email"></b-input>
                        </b-field>
                        <b-field label="Password">
                            <b-input type="password" v-model="password" password-reveal></b-input>
                        </b-field>
                        <a @click="registration_setup()">
                            <p>{{ this.text}}</p>
                        </a>
                        <br />
                        <b-field v-if="!this.registration">
                            <button class="button is-primary" @click="login()">Login</button>
                        </b-field>
                        <b-field v-if="this.registration">
                            <button class="button is-primary" @click="register()">Sign up</button>
                        </b-field>
                    </section>
                </div>
            </div>
        </div>
        <TheFooter />
    </div>
</template>

<script>
import TheNavbar from "../ui/TheNavbar";
import TheFooter from "../ui/TheFooter";
const axios = require("axios").default;
import { SnackbarProgrammatic as Snackbar } from "buefy";
import router from "../../router";

// For production
const url = "https://xelinion.servebeer.com:8443/unito-pandemic-rest-backend-1.0/";
// For dev
// const url = "http://localhost:8080/";

export default {
    name: "HomePage",
    components: {
        TheNavbar,
        TheFooter
    },
    data() {
        return {
            email: "",
            password: "",
            registration: false,
            text: "Do you need an account ? Sign up here",
            jwt: ""
        };
    },
    methods: {
        login() {
            axios
                .post(url + "api/back/signin", {
                    email: this.email,
                    password: this.password
                })
                .then(response => {
                    Snackbar.open("Welcome back " + response.data.email);
                    this.jwt = response.data.token;
                    localStorage.setItem("jwt", response.data.token);
                    setTimeout(() => {
                        router.replace("/dashboard");
                    }, 400);
                })
                .catch(error => {
                    Snackbar.open("Not working: " + error);
                });
        },
        register() {
            axios
                .post(url + "api/register_back", {
                    email: this.email,
                    password: this.password
                })
                .then(response => {
                    Snackbar.open(
                        "New user " + response.data.email + " registered"
                    );
                })
                .catch(error => {
                    Snackbar.open("Error " + error);
                });
        },
        registration_setup() {
            if (this.registration) {
                this.text = "Do you need an account ? Sign up here";
            } else {
                this.text = "Do you already have an account ? Sign in here";
            }
            this.registration = !this.registration;
        }
    }
};
</script>

<style scoped>
.is-padded {
    padding: 6rem !important;
}
</style>
